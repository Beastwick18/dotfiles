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

map("n", "j", "gj")
map("n", "k", "gk")

-- Tab movement
map("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })

-- Saving and exiting
map("n", ";w", ":w<cr>", { silent = true, desc = "Write file" })
map("n", ";q", ":q<cr>", { silent = true, desc = "Quit file" })

-- Window/buffer management
map("n", "<leader>w", "<c-w>")
map("n", "<C-c>", "<cmd>bn<bar>bd#<cr>", { noremap = true })

-- Normal and visual mode movement
map("n", "H", "^", { desc = "Goto beginning of line" })
map("n", "J", "}", { desc = "Go down paragraph" })
map("n", "K", "{", { desc = "Go up paragraph", noremap = true })
map("n", "L", "$", { desc = "Goto end of line" })
map("v", "H", "^", { desc = "Goto beginning of line" })
map("v", "J", "}", { desc = "Go down paragraph" })
map("v", "K", "{", { desc = "Go up paragraph", noremap = true })
map("v", "L", "$", { desc = "Goto end of line" })

-- Normal move lines
map("n", "<c-j>", "<cmd>move +1<cr>", { desc = "Move down in insert mode" })
map("n", "<c-k>", "<cmd>move -2<cr>", { desc = "Move up in insert mode" })

-- Insert mode movement
map("i", "<c-h>", "<left>", { desc = "Move left in insert mode" })
map("i", "<c-j>", "<cmd>move +1<cr>", { desc = "Move down in insert mode" })
map("i", "<c-k>", "<cmd>move -2<cr>", { desc = "Move up in insert mode" })
map("i", "<c-l>", "<right>", { desc = "Move right in insert mode" })

-- Normal mode window movement
map("n", "<c-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<c-j>", "<C-w>j", { desc = "Move to window below" })
map("n", "<c-k>", "<C-w>k", { desc = "Move to window above" })
map("n", "<c-l>", "<C-w>l", { desc = "Move to right window" })

map("n", "<F1>", "<nop>")
map("i", "<F1>", "<nop>")

map("n", "gn", "<cmd>Gitsigns next_hunk<cr>")
map("n", "gp", "<cmd>Gitsigns prev_hunk<cr>")

-- LSP mappings
map("n", "<leader>qf", vim.lsp.buf.code_action)
map("n", "<C-.>", vim.lsp.buf.code_action)
map("n", "<C-n>", vim.lsp.buf.code_action)
map("n", "<leader>n", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)
map("n", "<leader>p", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)
map("i", "<C-.>", vim.lsp.buf.code_action)
map("i", "<C-n>", function()
	vim.lsp.buf.code_action()
end)
map("n", "<leader>rn", function()
	vim.lsp.buf.rename()
end, { desc = "Rename", noremap = false })
map("n", "<F2>", function()
	vim.lsp.buf.rename()
end, { desc = "Rename", noremap = false })
vim.cmd([[vmap S ys]])

-- Neotree mappings
map({ "n", "i", "t" }, "<C-\\>", "<cmd>Neotree toggle<cr>", { noremap = true })

-- -- map("n", "m", "h") -- move Left
-- map("n", "n", "gj") -- move Down (g to allow move within wrapped lines)
-- map("n", "e", "gk") -- move Up (g to allow move within wrapped lines)
-- map("n", "i", "l") -- move Right
-- map("n", "t", "i") -- (t)ype           replaces (i)nsert
-- map("n", "T", "I") -- (T)ype at bol    replaces (I)nsert
-- map("n", "E", "e") -- end of word      replaces (e)nd
-- map("n", "k", "n") -- next match       replaces (n)ext
-- map("n", "K", "N") -- previous match   replaces (N) prev
--
-- -- Visual Colemak
-- -- map("v", "m", "h") -- move Left
-- map("v", "n", "gj") -- move Down (g to allow move within wrapped lines)
-- map("v", "e", "gk") -- move Up (g to allow move within wrapped lines)
-- map("v", "I", "l") -- move Right - shifted to fix [v]isual[i]n[...]
