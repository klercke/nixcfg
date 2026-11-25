-- Snacks covers the picker, file explorer, lazygit, terminal and indent guides.
-- These are the same pieces LazyVim uses.
require("snacks").setup({
  bigfile = { enabled = true },
  explorer = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  lazygit = { enabled = true },
  notifier = { enabled = true },
  picker = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  words = { enabled = true },
})

require("mini.pairs").setup()
require("mini.ai").setup({ n_lines = 500 })
-- Same gs* mappings as LazyVim's mini-surround extra.
require("mini.surround").setup({
  n_lines = 500,
  mappings = {
    add = "gsa",
    delete = "gsd",
    find = "gsf",
    find_left = "gsF",
    highlight = "gsh",
    replace = "gsr",
  },
})

require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = { delay = 300 },
  on_attach = function(buf)
    local gs = require("gitsigns")
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
    end

    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, "Next Hunk")
    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, "Prev Hunk")
    map({ "n", "x" }, "<leader>ghs", ":Gitsigns stage_hunk<cr>", "Stage Hunk")
    map({ "n", "x" }, "<leader>ghr", ":Gitsigns reset_hunk<cr>", "Reset Hunk")
    map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
    map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
    map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
    map("n", "<leader>ghb", function()
      map("n", "<leader>uB", gs.toggle_current_line_blame, "Toggle Line Blame")
      gs.blame_line({ full = true })
    end, "Blame Line")
    map("n", "<leader>ghd", gs.diffthis, "Diff This")
  end,
})
