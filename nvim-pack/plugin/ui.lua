local function gh(href)
  return "https://github.com/" .. href
end

vim.pack.add({
  gh("catppuccin/nvim"),
  gh("folke/snacks.nvim"),
  gh("folke/noice.nvim"),
  gh("rcarriga/nvim-notify"),
  gh("akinsho/bufferline.nvim"),
  gh("nvim-lualine/lualine.nvim"),
  gh("nvim-tree/nvim-web-devicons"),
  gh("nvim-neo-tree/neo-tree.nvim"),
  gh("MunifTanjim/nui.nvim"),
  gh("nvim-lua/plenary.nvim"),
})

-- [[ neo-tree ]]
require("neo-tree").setup({
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      visible = true,
    },
    bind_to_cwd = false,
    use_libuv_file_watcher = true,
  },
  default_component_configs = {
    indent = {
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
  },
})

-- [[ catppuccin ]]
require("catppuccin").setup({
  transparent_background = true,
  lsp_styles = {
    underlines = {
      errors = { "undercurl" },
      hints = { "undercurl" },
      warnings = { "undercurl" },
      information = { "undercurl" },
    },
  },
  integrations = {
    aerial = true,
    alpha = true,
    cmp = true,
    dashboard = true,
    flash = true,
    fzf = true,
    grug_far = true,
    gitsigns = true,
    headlines = true,
    illuminate = true,
    indent_blankline = { enabled = true },
    leap = true,
    lsp_trouble = true,
    mason = true,
    mini = true,
    navic = { enabled = true, custom_bg = "lualine" },
    neotest = true,
    neotree = true,
    noice = true,
    notify = true,
    snacks = true,
    telescope = true,
    treesitter_context = true,
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin")

-- [[ lualine ]]
require("lualine").setup({
  sections = {
    lualine_z = {
      function()
        return " " .. os.date("%-I:%02M %p")
      end,
    },
  },
  options = {
    disabled_filetypes = {
      "neo-tree",
    },
  },
})

require("bufferline").setup({
  options = {
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo-tree",
        separator = true,
        text_align = "center",
      },
    },
  },
  highlights = require("catppuccin.special.bufferline").get_theme(),
})

require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
  },
  notify = {
    enabled = true,
    view = "notify",
  },
})

require("notify").setup({
  background_colour = "#000000",
  merge_duplicates = true,
})

vim.notify = require("notify")
require("snacks").setup({
  bigfile = { enabled = true },
  -- dashboard = { enabled = true },
  -- explorer = { enabled = true },
  -- indent = { enabled = true },
  -- input = { enabled = true },
  -- picker = { enabled = true },
  -- notifier = { enabled = true },
  -- quickfile = { enabled = true },
  -- scope = { enabled = true },
  -- scroll = { enabled = true },
  statuscolumn = {
    enabled = true,
    left = { "mark", "sign" }, -- priority of signs on the left (high to low)
    right = { "fold", "git" }, -- priority of signs on the right (high to low)
    folds = {
      open = false,          -- show open fold icons
      git_hl = false,        -- use Git Signs hl for fold icons
    },
    git = {
      -- patterns to match Git signs
      patterns = { "GitSign", "MiniDiffSign" },
    },
    refresh = 50,
  },
  -- words = { enabled = true },
})
