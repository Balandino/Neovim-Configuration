require("nvim_comment").setup()

vim.api.nvim_create_augroup("comment_symbol", { clear = true })

-- Changes the default comment when using gcc from /* */ to //
vim.api.nvim_create_autocmd("BufEnter", {
	group = "comment_symbol",
	pattern = "*.cpp,*.h,*.c,*.java",
	callback = function()
		vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
	end,
})

-- Changes the default comment when using gcc from /* */ to //
vim.api.nvim_create_autocmd("BufFilePost", {
	group = "comment_symbol",
	pattern = "*.cpp,*.h,*.c,*.java",
	callback = function()
		vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = "comment_symbol",
	pattern = "*.php",
	callback = function()
		vim.api.nvim_buf_set_option(0, "commentstring", "<!-- %s -->")
	end,
})
