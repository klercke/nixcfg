-- vimtex reads these globals when it loads, so they have to be set first.
-- zathura (non-simple) needs xdotool, which doesn't work on Wayland.
vim.g.vimtex_view_method = "zathura_simple"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_view_forward_search_on_start = 0

require("render-markdown").setup({
  code = { sign = false, width = "block", right_pad = 1 },
  heading = { sign = false, icons = {} },
})
