-- Parsers are compiled locally, which needs the tree-sitter CLI (0.26.1+) and a C compiler.
-- install() is async and does nothing for parsers that are already there.
require("nvim-treesitter").install({
  "bash",
  "diff",
  "dockerfile",
  "git_rebase",
  "gitcommit",
  "go",
  "gomod",
  "gosum",
  "hcl",
  "json",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "nix",
  "python",
  "query",
  "regex",
  "rust",
  "terraform",
  "toml",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("d0c_treesitter", { clear = true }),
  callback = function(ev)
    -- vimtex does its own highlighting.
    if ev.match == "tex" then
      return
    end
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang or not vim.treesitter.language.add(lang) then
      return
    end
    vim.treesitter.start(ev.buf, lang)
    -- Only use treesitter indent where the parser ships indent queries.
    if vim.treesitter.query.get(lang, "indents") then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
