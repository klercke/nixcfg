-- Language servers come from PATH.
-- On NixOS that means a project's devShell, plus a few global ones from Home Manager.
-- Everywhere else, Mason downloads them into its own bin dir and puts that on PATH.

if not vim.g.is_nixos then
  require("mason").setup()

  -- Only tools Mason pulls as GitHub release binaries, so a locked-down machine can get them.
  -- Anything else can be added by hand with :MasonInstall.
  local ensure = {
    "lua-language-server",
    "marksman",
    "stylua",
    "taplo",
    "terraform-ls",
    "tflint",
  }
  local registry = require("mason-registry")
  registry.refresh(function()
    for _, name in ipairs(ensure) do
      local ok, pkg = pcall(registry.get_package, name)
      if ok and not pkg:is_installed() then
        pkg:install()
      end
    end
  end)
end

local nixcfg = vim.fn.expand("~/nixcfg")
local flake = '(builtins.getFlake "' .. nixcfg .. '")'
local host = flake .. ".nixosConfigurations." .. vim.fn.hostname()

-- Settings layered on top of nvim-lspconfig's defaults for each server.
local servers = {
  basedpyright = {},
  gopls = {},
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME, vim.fn.stdpath("data") .. "/site/pack/core/opt" },
        },
      },
    },
  },
  marksman = {},
  nixd = {
    settings = {
      nixd = {
        nixpkgs = { expr = "import " .. flake .. ".inputs.nixpkgs { }" },
        options = {
          ["flake-parts"] = { expr = flake .. ".debug.options" },
          nixos = { expr = host .. ".options" },
          ["home-manager"] = { expr = host .. ".options.home-manager.users.type.getSubOptions [ ]" },
        },
        diagnostic = { suppress = { "sema-escaping-with", "var-bind-to-this" } },
      },
    },
  },
  ruff = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        check = { command = "clippy" },
        inlayHints = { lifetimeElisionHints = { enable = "always" } },
        files = { excludeDirs = { "target", ".git", ".cargo", ".github", ".direnv" } },
      },
    },
  },
  taplo = {},
  terraformls = {},
  texlab = {},
  tflint = {},
}

-- Only enable servers that are actually installed, so missing ones stay quiet.
-- Start nvim from inside a devShell (direnv does this) so its servers are on PATH.
for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  local cmd = vim.lsp.config[name].cmd
  if type(cmd) ~= "table" or vim.fn.executable(cmd[1]) == 1 then
    vim.lsp.enable(name)
  end
end

vim.diagnostic.config({
  virtual_text = { spacing = 2 },
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("d0c_lsp", { clear = true }),
  callback = function(ev)
    local function map(lhs, rhs, desc, mode)
      vim.keymap.set(mode or "n", lhs, rhs, { buffer = ev.buf, desc = desc, nowait = true })
    end

    -- K (hover) and ]d/[d (diagnostics) are Neovim defaults.
    map("gd", function()
      Snacks.picker.lsp_definitions()
    end, "Goto Definition")
    map("gr", function()
      Snacks.picker.lsp_references()
    end, "References")
    map("gI", function()
      Snacks.picker.lsp_implementations()
    end, "Goto Implementation")
    map("gy", function()
      Snacks.picker.lsp_type_definitions()
    end, "Goto Type Definition")
    map("gD", function()
      Snacks.picker.lsp_declarations()
    end, "Goto Declaration")
    map("gK", vim.lsp.buf.signature_help, "Signature Help")
    map("<c-k>", vim.lsp.buf.signature_help, "Signature Help", "i")
    map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
    map("<leader>cr", vim.lsp.buf.rename, "Rename")
    map("<leader>ss", function()
      Snacks.picker.lsp_symbols()
    end, "LSP Symbols")
    map("<leader>cl", "<cmd>checkhealth vim.lsp<cr>", "LSP Info")

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end
  end,
})

-- Servers that are still indexing answer the first inlay hint request with nothing.
-- Ask again each time the server reports that a piece of work has finished.
vim.api.nvim_create_autocmd("LspProgress", {
  group = vim.api.nvim_create_augroup("d0c_inlay_hints", { clear = true }),
  pattern = "end",
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end
    for buf in pairs(client.attached_buffers) do
      if vim.lsp.inlay_hint.is_enabled({ bufnr = buf }) then
        vim.lsp.inlay_hint.enable(false, { bufnr = buf })
        vim.lsp.inlay_hint.enable(true, { bufnr = buf })
      end
    end
  end,
})
