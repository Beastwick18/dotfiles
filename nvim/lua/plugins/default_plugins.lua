return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			sections = {
				lualine_z = {
					function()
						return " " .. os.date("%-I:%02M %p")
					end,
				},
			},
		},
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "catppuccin-mocha",
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true,
		},
	},
	{
		"folke/noice.nvim",
		keys = {
			{ "<C-d>", "<cmd>NoiceDismiss<cr>", desc = "Dismiss notification" },
		},
	},
	{
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "ys",
				delete = "ds",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "cs",
				update_n_lines = "gsn",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = function(_, opts)
			opts.ensure_installed = {}
			opts.automatic_installation = { exclude = { "tsserver" } }
		end,
	},
	{
		"williamboman/mason.nvim",
		enabled = true,
		-- opts = function(_, opts)
		-- 	opts.ensure_installed = {}
		-- end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{ "windwp/nvim-ts-autotag" },
		},
		opts = {
			autotag = {
				enable = true,
				enable_rename = true,
				enable_close = true,
				enable_close_on_slash = false, -- broken for now
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false,
		keys = {
			{
				"<C-\\>",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root.get() })
				end,
				mode = { "n", "i", "t" },
				desc = "Open file browser",
			},
		},
		opts = {
			close_if_last_window = true,
			filesystem = {
				filtered_items = {
					visible = true,
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		init = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			keys[#keys + 1] = { "K", false }
			keys[#keys + 1] = { "<c-k>", false, mode = "i" }
		end,
		opts = {
			diagnostics = {
				virtual_text = false,
			},
			inlay_hints = { enabled = true },
			servers = {
				taplo = {
					keys = {},
				},
			},
			setup = {
				rust_analyzer = function()
					return true
				end,
			},
		},
	},
	-- 	-- setup = {
	-- 	-- 	tsserver = function(_, opts)
	-- 	-- 		require("lspconfig").tsserver.setup {
	-- 	-- 			require("mason-lspconfig.typescript").setup {
	-- 	-- 				server = opts
	-- 	-- 			}
	-- 	-- 		}
	-- 	-- 	end
	-- 	-- },
	-- 	opts = {
	-- 		-- make sure mason installs the server
	-- 		servers = {
	-- 			---@type lspconfig.options.tsserver
	-- 			tsserver = {
	-- 				enabled = true,
	-- 				keys = {
	-- 					{
	-- 						"<leader>co",
	-- 						function()
	-- 							vim.lsp.buf.code_action({
	-- 								apply = true,
	-- 								context = {
	-- 									only = { "source.organizeImports.ts" },
	-- 									diagnostics = {},
	-- 								},
	-- 							})
	-- 						end,
	-- 						desc = "Organize Imports",
	-- 					},
	-- 					{
	-- 						"<leader>cR",
	-- 						function()
	-- 							vim.lsp.buf.code_action({
	-- 								apply = true,
	-- 								context = {
	-- 									only = { "source.removeUnused.ts" },
	-- 									diagnostics = {},
	-- 								},
	-- 							})
	-- 						end,
	-- 						desc = "Remove Unused Imports",
	-- 					},
	-- 				},
	-- 				---@diagnostic disable-next-line: missing-fields
	-- 				settings = {
	-- 					completions = {
	-- 						completeFunctionCalls = true,
	-- 					},
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- 	-- opts = {
	-- 	-- 	servers = {
	-- 	-- 		tsserver = {
	-- 	-- 			settings = {
	-- 	-- 				typescript = {
	-- 	-- 					preferGoToSourceDefinition = true,
	-- 	-- 				},
	-- 	-- 			},
	-- 	-- 		},
	-- 	-- 	},
	-- 	-- },
	-- 	-- setup = {
	-- 	-- 	tsserver = function(_, opts)
	-- 	-- 		require 'lspconfig'.tsserver.setup {
	-- 	-- 		-- require("typescript").setup({ server = opts })
	-- 	-- 		return true
	-- 	-- 	end,
	-- 	-- },
	-- 	-- }
	-- },
	{
		"echasnovski/mini.indentscope",
		opts = {
			draw = {
				delay = 000,

				animation = function()
					return 0
				end,

				priority = 2,
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
	{
		"saghen/blink.cmp",
		opts = {
			sources = {
				-- adding any nvim-cmp sources here will enable them
				-- with blink.compat
				compat = {},
				default = { "lsp", "path", "snippets", "buffer" },
			},
			keymap = {
				preset = "super-tab",
				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },

				-- workaround because lazyvim is too lazy to merge PR
				["<Tab>"] = {
					require("blink.cmp.keymap.presets").get("super-tab")["<Tab>"][1],
					require("lazyvim.util.cmp").map({ "snippet_forward", "ai_accept" }),
					"fallback",
				},

				-- -- disable a keymap from the preset
				-- ["<C-e>"] = {},
				--
				-- -- show with a list of providers
				-- ["<C-space>"] = {
				-- 	function(cmp)
				-- 		cmp.show({ providers = { "snippets" } })
				-- 	end,
				-- },
			},
		},
	},
	{
		"snacks.nvim",
		opts = {
			-- indent = { enabled = true },
			input = { enabled = false },
			-- notifier = { enabled = true },
			-- scope = { enabled = true },
			scroll = { enabled = false },
			-- statuscolumn = { enabled = false }, -- we set this in options.lua
			-- toggle = { map = LazyVim.safe_keymap_set },
			-- words = { enabled = true },
		},
		keys = {
			{ "<leader>n", nil },
			{ "<leader>un", nil },
		},
	},
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	dependencies = {
	-- 		"hrsh7th/cmp-emoji",
	-- 	},
	-- 	---@param opts cmp.ConfigSchema
	-- 	opts = function(_, opts)
	-- 		local has_words_before = function()
	-- 			unpack = unpack or table.unpack
	-- 			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	-- 			return col ~= 0
	-- 				and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	-- 		end
	--
	-- 		local luasnip = require("luasnip")
	-- 		local cmp = require("cmp")
	--
	-- 		opts.mapping = vim.tbl_extend("force", opts.mapping, {
	-- 			["<CR>"] = cmp.mapping(function(fallback)
	-- 				cmp.close()
	-- 				fallback()
	-- 			end, { "i" }),
	-- 			["<Tab>"] = cmp.mapping(function(fallback)
	-- 				if
	-- 					not cmp.visible()
	-- 					or not cmp.get_selected_entry()
	-- 					or cmp.get_selected_entry().source.name == "nvim_lsp_signature_help"
	-- 				then
	-- 					fallback()
	-- 				else
	-- 					cmp.confirm({ cmp.ConfirmBehavior.Replace, select = false })
	-- 				end
	-- 			end, { "i", "s" }),
	-- 			["<c-j>"] = cmp.mapping(function(fallback)
	-- 				if cmp.visible() then
	-- 					cmp.select_next_item()
	-- 					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
	-- 					-- this way you will only jump inside the snippet region
	-- 				elseif luasnip.expand_or_jumpable() then
	-- 					luasnip.expand_or_jump()
	-- 				elseif has_words_before() then
	-- 					cmp.complete()
	-- 				else
	-- 					fallback()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 			["<c-k>"] = cmp.mapping(function(fallback)
	-- 				if cmp.visible() then
	-- 					cmp.select_prev_item()
	-- 				elseif luasnip.jumpable(-1) then
	-- 					luasnip.jump(-1)
	-- 				else
	-- 					fallback()
	-- 				end
	-- 			end, { "i", "s" }),
	-- 		})
	-- 	end,
	-- },
}
