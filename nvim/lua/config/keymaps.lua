local function map(mode, lhs, rhs, opts)
	--local keys = require("lazy.core.handler").handlers.keys
	-- ---@cast keys LazyKeysHandler
	-- do not create the keymap if a lazy keys handler exists
	opts = opts or {}
	opts.silent = opts.silent ~= false
	if opts.remap and not vim.g.vscode then
		opts.remap = nil
	end
	vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
map("n", ";w", ":w<cr>", { silent = true, desc = "Write file" })
map("n", ";q", ":q<cr>", { silent = true, desc = "Quit file" })
map("n", "<leader>w", "<c-w>")
map("n", "H", "^", { desc = "Goto beginning of line" })
map("n", "J", "}", { desc = "Go down paragraph" })
map("n", "K", "{", { desc = "Go up paragraph", noremap = true })
map("n", "L", "$", { desc = "Goto end of line" })
map("v", "H", "^", { desc = "Goto beginning of line" })
map("v", "J", "}", { desc = "Go down paragraph" })
map("v", "K", "{", { desc = "Go up paragraph", noremap = true })
map("v", "L", "$", { desc = "Goto end of line" })
-- map({ "n", "i", "t" }, "<C-\\>", function()
-- 	require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
-- end, { desc = "Open file browser" })

map("i", "<c-h>", "<left>", { desc = "Move left in insert mode" })
map("i", "<c-j>", "<down>", { desc = "Move down in insert mode" })
map("i", "<c-k>", "<up>", { desc = "Move up in insert mode" })
map("i", "<c-l>", "<right>", { desc = "Move right in insert mode" })

map("n", "<F1>", "<nop>")
map("i", "<F1>", "<nop>")

map("n", "<leader>qf", "<cmd>lua vim.lsp.buf.code_action()<cr>")
map("n", "<C-n>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
map({ "i" }, "<C-n>", function()
	vim.lsp.buf.code_action()
end)
map("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end, { desc = "Rename", noremap = false })
map("n", "<F2>", function()
	vim.lsp.buf.rename()
end, { desc = "Rename", noremap = false })
map("v", "S", "ys")

-- map("n", "<leader>p", function()
-- 	-- require("nabla").enable_virt({
-- 	-- 	autogen = true,
-- 	-- 	silent = true,
-- 	-- 	align_center = false,
-- 	-- })
-- 	require("nabla").toggle_virt({
-- 		autogen = true,
-- 		silent = true,
-- 		align_center = false,
-- 	})
-- end)
