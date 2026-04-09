local function gh(href)
  return "https://github.com/" .. href
end

vim.pack.add({
  gh("saghen/blink.cmp"),
  gh("rafamadriz/friendly-snippets"),
  gh("folke/lazydev.nvim"),
  gh("neovim/nvim-lspconfig"),
  gh("mason-org/mason.nvim"),
})

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
vim.lsp.config("*", {})

require("mason").setup()

vim.lsp.enable({
  "lua_ls",
  "stylua",
  "rust_analyzer",
})

require("blink.cmp").setup({
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  keymap = {
    preset = "super-tab",
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },
  },
  completion = {
    accept = {
      -- experimental auto-brackets support
      auto_brackets = {
        enabled = true,
      },
    },
    menu = {
      draw = {
        treesitter = { "lsp" },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      enabled = vim.g.ai_cmp,
    },
  },
})

require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "LazyVim",            words = { "LazyVim" } },
    { path = "snacks.nvim",        words = { "Snacks" } },
    { path = "lazy.nvim",          words = { "LazyVim" } },
    { path = "nvim-lspconfig",     words = { "lspconfig.settings" } },
  },
})
