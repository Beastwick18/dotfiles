local function gh(href)
  return "https://github.com/" .. href
end

-- [[ mini.nvim ]]
vim.pack.add({
  gh("nvim-mini/mini.nvim"),
})

require("mini.surround").setup({
  mappings = {
    add = "ys",
    delete = "ds",
    find = "gsf",
    find_left = "gsF",
    highlight = "gsh",
    replace = "cs",
    update_n_lines = "gsn",
  },
})

require("mini.pick").setup({
  window = {
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
})

require("mini.pairs").setup({
  modes = { insert = true, command = true, terminal = false },
  -- skip autopair when next character is one of these
  skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
  -- skip autopair when the cursor is inside these treesitter nodes
  skip_ts = { "string" },
  -- skip autopair when next character is closing pair
  -- and there are more closing pairs than opening pairs
  skip_unbalanced = true,
  -- better deal with markdown code blocks
  markdown = true,
})

local ai = require("mini.ai")
require("mini.ai").setup({
  {
    n_lines = 500,
    custom_textobjects = {
      o = ai.gen_spec.treesitter({ -- code block
        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
      }),
      f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
      c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),    -- class
      t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },        -- tags
      d = { "%f[%d]%d+" },                                                       -- digits
      e = {                                                                      -- Word with case
        { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
        "^().*()$",
      },
      u = ai.gen_spec.function_call(),                        -- u for "Usage"
      U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
    },
  },
})
