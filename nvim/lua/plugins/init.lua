-- Every plugin is listed here and installed in one vim.pack.add() call.
-- The lua/plugins/*.lua files only configure them.
-- Update with :lua vim.pack.update(), review the buffer it opens, then :write to apply.

-- Hooks have to exist before vim.pack.add() runs.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    -- Parsers have to match the plugin version, so rebuild them after an update.
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

local function gh(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  -- UI
  gh("ellisonleao/gruvbox.nvim"),
  gh("nvim-lualine/lualine.nvim"),
  gh("folke/which-key.nvim"),

  -- Editor
  gh("folke/snacks.nvim"),
  gh("nvim-mini/mini.nvim"),
  gh("lewis6991/gitsigns.nvim"),

  -- Coding
  -- The 1.x tags ship prebuilt fuzzy matcher binaries; 2.x is still in development.
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
  gh("rafamadriz/friendly-snippets"),
  gh("stevearc/conform.nvim"),
  gh("Kaiser-Yang/blink-cmp-git"),
  gh("disrupted/blink-cmp-conventional-commits"),

  -- Treesitter and LSP
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  gh("neovim/nvim-lspconfig"),
  -- Installed everywhere to keep the lockfile the same, but only set up off NixOS.
  gh("mason-org/mason.nvim"),

  -- Languages
  gh("lervag/vimtex"),
  gh("MeanderingProgrammer/render-markdown.nvim"),
})
