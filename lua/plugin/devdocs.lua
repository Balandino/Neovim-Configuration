require("nvim-devdocs").setup({
	dir_path = vim.fn.stdpath("data") .. "/devdocs", -- installation directory
	telescope = {}, -- passed to the telescope picker
	float_win = { -- passed to nvim_open_win(), see :h api-floatwin
		relative = "editor",
		height = 60,
		width = 200,
		border = "rounded",
	},
	wrap = false, -- text wrap, only applies to floating window
	previewer_cmd = "glow", -- for example: "glow"
	cmd_args = { "-s", "dark", "-w", "200" }, -- example using glow: { "-s", "dark", "-w", "80" }
	cmd_ignore = {}, -- ignore cmd rendering for the listed docs
	picker_cmd = false, -- use cmd previewer in picker preview
	picker_cmd_args = {}, -- example using glow: { "-p" }
	ensure_installed = {}, -- get automatically installed
	after_open = function(bufnr)
		vim.api.nvim_buf_set_keymap(bufnr, "n", "q", ":close<CR>", {})
	end,
})
