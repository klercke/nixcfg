-- Enter accepts, <C-space> opens the menu, <C-n>/<C-p> or arrows move, <C-e> closes.
-- That is LazyVim's "enter" preset.
require("blink.cmp").setup({
  keymap = {
    preset = "enter",
    ["<C-y>"] = { "select_and_accept" },
  },
  appearance = { nerd_font_variant = "mono" },
  completion = {
    accept = { auto_brackets = { enabled = true } },
    menu = { draw = { treesitter = { "lsp" } } },
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
    ghost_text = { enabled = true },
  },
  sources = {
    default = { "conventional_commits", "git", "lsp", "path", "snippets", "buffer" },
    providers = {
      -- feat, fix, chore and friends, plus scopes already used in this repo.
      conventional_commits = {
        name = "Conventional Commits",
        module = "blink-cmp-conventional-commits",
        enabled = function()
          return vim.bo.filetype == "gitcommit"
        end,
      },
      -- ":" for commits, "#" for issues and PRs, "@" for people.
      -- Uses gh for GitHub and glab for GitLab, falling back to unauthenticated curl.
      git = {
        name = "Git",
        module = "blink-cmp-git",
        -- The plugin assumes the trigger character is right before the cursor.
        -- After typing "#6" it would replace only the "6" and leave a second "#".
        -- Start the replacement at the trigger instead.
        transform_items = function(ctx, items)
          for _, item in ipairs(items) do
            -- blink-cmp-git sets this field on its items but doesn't declare it in its types.
            local trigger = rawget(item, "gitSourceTrigger") --[[@as string?]]
            if trigger and item.textEdit then
              item.textEdit.range.start.character = ctx.bounds.start_col - 1 - #trigger
            end
          end
          return items
        end,
        enabled = function()
          return vim.tbl_contains({ "gitcommit", "markdown" }, vim.bo.filetype)
        end,
        -- GitHub returns 30 items by default, and PRs count toward the 30 for issues.
        -- Ask for 100 so older open issues still show up.
        opts = {
          git_centers = {
            github = {
              issue = {
                get_command_args = function(command, token)
                  local common = require("blink-cmp-git.default.common")
                  local repo = require("blink-cmp-git.utils").get_repo_owner_and_repo()
                  return common.github_api_args(command, token, "repos/" .. repo .. "/issues?per_page=100")
                end,
              },
              pull_request = {
                get_command_args = function(command, token)
                  local common = require("blink-cmp-git.default.common")
                  local repo = require("blink-cmp-git.utils").get_repo_owner_and_repo()
                  return common.github_api_args(command, token, "repos/" .. repo .. "/pulls?per_page=100")
                end,
              },
            },
          },
        },
      },
    },
  },
  signature = { enabled = true },
  -- Use the prebuilt Rust matcher when it loads and fall back to Lua quietly when it doesn't.
  fuzzy = { implementation = "prefer_rust" },
})

-- Anything not listed formats through the LSP (rust-analyzer, gopls, terraform-ls, taplo, texlab).
require("conform").setup({
  default_format_opts = { lsp_format = "fallback", timeout_ms = 3000 },
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixfmt" },
    python = { "ruff_format" },
  },
  format_on_save = function(buf)
    if vim.g.autoformat == false or vim.b[buf].autoformat == false then
      return
    end
    return {}
  end,
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
