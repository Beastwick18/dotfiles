local after_update = function(opts)
	local autocmd_opts = vim.deepcopy(opts)
	autocmd_opts.command = nil
	autocmd_opts.delay = nil
	autocmd_opts.callback = function(e)
		if e.data.kind ~= "update" then
			return
		end
		local run = function()
			if opts.command then
				vim.cmd(opts.command)
			else
				opts.callback(e)
			end
		end
		vim.defer_fn(run, opts.delay or 200)
	end
	vim.api.nvim_create_autocmd("PackChanged", autocmd_opts)
end

after_update({
	pattern = "blink.cmp",
	desc = "Run `:BlinkCmp build` after pack update",
	group = vim.api.nvim_create_augroup("blink_update", { clear = true }),
	command = "echo '' | BlinkCmp build",
})

after_update({
	pattern = "nvim-treesitter",
	desc = "Run `:TSUpdate` after pack update",
	group = vim.api.nvim_create_augroup("ts_update", { clear = true }),
	callback = function(ev)
		if not ev.data.active then
			vim.cmd.packadd("nvim-treesitter")
		end
		vim.cmd("TSUpdate")
	end,
})

-- Show lsp diagnostics (warnings and errors) popup on cursor hover
vim.o.updatetime = 250
vim.diagnostic.config({
	float = { border = "rounded" },
	signs = {
		active = true,
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "󰟃",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})
vim.api.nvim_create_autocmd({ "CursorHold" }, {
	callback = function()
		if vim.fn.mode() == "n" then
			vim.diagnostic.open_float(nil, {
				focus = false,
				scope = "cursor",
			})
		end
	end,
})

vim.api.nvim_create_user_command("PackUpdate", vim.pack.update, {})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function ()
    vim.lsp.buf.format()
  end,
})
