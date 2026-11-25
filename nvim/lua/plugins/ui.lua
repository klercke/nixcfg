require("mini.icons").setup()
-- Plugins that want nvim-web-devicons get mini.icons instead.
require("mini.icons").mock_nvim_web_devicons()

-- Matches the gruvbox-dark-hard scheme Stylix uses for everything else.
require("gruvbox").setup({ contrast = "hard" })
vim.cmd.colorscheme("gruvbox")

require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
  },
})

require("which-key").setup({
  preset = "helix",
  spec = {
    { "<leader>b", group = "buffer" },
    { "<leader>c", group = "code" },
    { "<leader>f", group = "file/find" },
    { "<leader>g", group = "git" },
    { "<leader>gh", group = "hunks" },
    { "<leader>q", group = "quit" },
    { "<leader>s", group = "search" },
    { "<leader>u", group = "ui" },
    { "<leader>w", group = "windows", proxy = "<c-w>" },
    { "[", group = "prev" },
    { "]", group = "next" },
    { "g", group = "goto" },
    { "gs", group = "surround" },
  },
})
