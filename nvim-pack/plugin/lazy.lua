local function gh(href)
	return "https://github.com/" .. href
end

-- [[ Plugins ]]
vim.pack.add({
	gh("nvim-mini/mini.nvim"),
	gh("catppuccin/nvim"),

	gh("nvim-neo-tree/neo-tree.nvim"),
	--[[ dependencies ]]
	gh("MunifTanjim/nui.nvim"),
	gh("nvim-lua/plenary.nvim"),

	gh("nvim-lualine/lualine.nvim"),
	--[[ dependencies ]]
	gh("nvim-tree/nvim-web-devicons"),

	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason.nvim"),
	gh("nvim-treesitter/nvim-treesitter"),

	gh("folke/noice.nvim"),
	gh("rcarriga/nvim-notify"),
	gh("akinsho/bufferline.nvim"),

	gh("saghen/blink.cmp"),
	gh("rafamadriz/friendly-snippets"),
	gh("folke/lazydev.nvim"),

	gh("folke/snacks.nvim"),
})

-- [[ mini.nvim ]]
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

-- [[ neo-tree ]]
require("neo-tree").setup({
	close_if_last_window = true,
	filesystem = {
		filtered_items = {
			visible = true,
		},
	},
})

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

--[[ LSP ]]
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (is_windows and "; " or ":") .. vim.env.PATH
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
		{ path = "LazyVim", words = { "LazyVim" } },
		{ path = "snacks.nvim", words = { "Snacks" } },
		{ path = "lazy.nvim", words = { "LazyVim" } },
		{ path = "nvim-lspconfig", words = { "lspconfig.settings" } },
	},
})

--[[ UI ]]
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
			open = false, -- show open fold icons
			git_hl = false, -- use Git Signs hl for fold icons
		},
		git = {
			-- patterns to match Git signs
			patterns = { "GitSign", "MiniDiffSign" },
		},
		refresh = 50,
	},
	-- words = { enabled = true },
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
