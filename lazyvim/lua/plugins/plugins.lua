return {
	{
		"mvllow/modes.nvim",
		version = "*",
		config = function()
			require("modes").setup({
				colors = {
					bg = "", -- Optional bg param, defaults to Normal hl group
					copy = "#f5c359",
					delete = "#c75c6a",
					insert = "#78ccc5",
					visual = "#00abff",
				},

				-- Set opacity for cursorline and number background
				line_opacity = 0.15,

				-- Enable cursor highlights
				set_cursor = true,

				-- Enable cursorline initially, and disable cursorline for inactive windows
				-- or ignored filetypes
				set_cursorline = true,

				-- Enable line number highlights to match cursorline
				set_number = true,

				-- Disable modes highlights in specified filetypes
				-- Please PR commonly ignored filetypes
				ignore_filetypes = { "neo-tree", "NvimTree", "TelescopePrompt" },
			})
		end,
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "minimal",
				options = {
					show_all_diags_on_cursorline = true,
					multiple_diag_under_cursor = true,
					throttle = 0,
					softwrap = 40,
					enable_on_insert = true,
					enable_on_select = true,
					multilines = {
						enabled = true,
						always_show = true,
					},
				},
			})
		end,
	},
	-- {
	-- 	"Beastwick18/nabla.nvim",
	-- 	branch = "tilde",
	-- 	keys = {
	-- 		{
	-- 			"<C-p>",
	-- 			function()
	-- 				require("nabla").toggle_virt({
	-- 					autogen = true,
	-- 					silent = true,
	-- 					align_center = false,
	-- 				})
	-- 			end,
	-- 			mode = { "n" },
	-- 			desc = "Nabla toggle virt",
	-- 		},
	-- 	},
	-- },
	{
		"nmac427/guess-indent.nvim",
		version = "*",
		config = function()
			require("guess-indent").setup({
				filetype_exclude = {
					"netrw",
					"tutor",
					"neo-tree",
				},
			})
		end,
	},
}
