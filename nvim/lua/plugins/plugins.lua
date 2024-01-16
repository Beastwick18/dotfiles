return {
	-- {
	-- 	"jbyuki/venn.nvim",
	-- },
	-- {
	-- 	"jbyuki/ntangle.nvim",
	-- },
	{
		"Beastwick18/nabla.nvim",
		branch = "tilde",
		keys = {
			{
				"<leader>p",
				function()
					require("nabla").toggle_virt({
						autogen = true,
						silent = true,
						align_center = false,
					})
				end,
				mode = { "n" },
				desc = "Nabla toggle virt",
			},
		},
	},
	-- {
	-- 	"jbyuki/nabla.nvim",
	-- },
	{
		"nmac427/guess-indent.nvim",
		version = "*",
		config = function()
			require("guess-indent").setup({})
		end,
	},
	-- {
	-- 	"kylechui/nvim-surround",
	-- 	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("nvim-surround").setup()
	-- 	end,
	-- },
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{
				"<leader>t",
				"<cmd>cd %:p:h<cr><cmd>ToggleTerm dir=%:p:h direction=horizontal<cr>",
				desc = "Open a horizontal terminal at the Desktop directory",
			},
		},
		opts = {
			size = 13,
		},
	},
}
