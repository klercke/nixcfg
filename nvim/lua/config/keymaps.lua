-- General keymaps, mostly LazyVim's defaults.
-- LSP keymaps live in plugins/lsp.lua and git hunk keymaps in plugins/editor.lua.

local map = vim.keymap.set

-- Move by display line when there's no count.
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })
map("n", "<leader>-", "<C-w>s", { desc = "Split Window Below" })
map("n", "<leader>|", "<C-w>v", { desc = "Split Window Right" })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete Window" })

-- Buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- Move lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Keep the selection when indenting.
map("x", "<", "<gv")
map("x", ">", ">gv")

map({ "i", "n", "s" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Keymaps" })

-- Formatting
map({ "n", "x" }, "<leader>cf", function()
  require("conform").format()
end, { desc = "Format" })
map("n", "<leader>uf", function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify("Autoformat " .. (vim.g.autoformat and "on" or "off"))
end, { desc = "Toggle Autoformat" })
map("n", "<leader>uF", function()
  vim.b.autoformat = vim.b.autoformat == false
  vim.notify("Buffer autoformat " .. (vim.b.autoformat and "on" or "off"))
end, { desc = "Toggle Autoformat (Buffer)" })

-- Picker and explorer
local function pick(source, opts)
  return function()
    Snacks.picker[source](opts)
  end
end

map("n", "<leader><space>", pick("files"), { desc = "Find Files" })
map("n", "<leader>/", pick("grep"), { desc = "Grep" })
map("n", "<leader>,", pick("buffers"), { desc = "Buffers" })
map("n", "<leader>:", pick("command_history"), { desc = "Command History" })
map("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "File Explorer" })

map("n", "<leader>fb", pick("buffers"), { desc = "Buffers" })
map("n", "<leader>fc", pick("files", { cwd = vim.fn.stdpath("config") }), { desc = "Find Config File" })
map("n", "<leader>ff", pick("files"), { desc = "Find Files" })
map("n", "<leader>fg", pick("git_files"), { desc = "Find Git Files" })
map("n", "<leader>fr", pick("recent"), { desc = "Recent" })
map("n", "<leader>fz", pick("zoxide"), { desc = "Zoxide" })

map("n", "<leader>sg", pick("grep"), { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", pick("grep_word"), { desc = "Grep Word" })
map("n", "<leader>sd", pick("diagnostics"), { desc = "Diagnostics" })
map("n", "<leader>sh", pick("help"), { desc = "Help Pages" })
map("n", "<leader>sk", pick("keymaps"), { desc = "Keymaps" })
map("n", "<leader>sR", pick("resume"), { desc = "Resume" })

-- Git and terminal
map("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "Lazygit" })
map("n", "<leader>gb", function()
  Snacks.git.blame_line()
end, { desc = "Git Blame Line" })
map("n", "<leader>gl", pick("git_log"), { desc = "Git Log" })
map({ "n", "t" }, "<C-/>", function()
  Snacks.terminal()
end, { desc = "Terminal" })
