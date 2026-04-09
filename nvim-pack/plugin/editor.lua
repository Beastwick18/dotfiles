local function gh(href)
  return "https://github.com/" .. href
end

vim.pack.add({
  gh("nvim-treesitter/nvim-treesitter"),
})

require("nvim-treesitter").setup({
  ensure_installed = {
    "bash",
    "c",
    "diff",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "printf",
    "python",
    "query",
    "regex",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
  },
})
