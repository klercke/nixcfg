vim.g.is_nixos = vim.uv.fs_stat("/etc/NIXOS") ~= nil

require("config.options")
require("plugins")
require("plugins.ui")
require("plugins.editor")
require("plugins.coding")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.lang")
require("config.keymaps")
require("config.autocmds")
