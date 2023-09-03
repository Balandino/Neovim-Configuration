local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

local error_notifier = {
	show = function()
		-- use opts.title and opts.body
		print("Format failed!")
	end,
	hide = function()
		-- hide the error when it's been resolved
		-- print("Formatting Complete!")
	end,
}

format_on_save.setup({
	exclude_path_patterns = {
		"/node_modules/",
		".local/share/nvim/lazy",
	},
	formatter_by_ft = {
		css = formatters.prettierd,
		html = formatters.prettierd,
		lua = formatters.stylua,
		-- python = formatters.black,

		python = {
			formatters.remove_trailing_whitespace,
			formatters.black,
		},
	},
	error_notifier = error_notifier,
	run_with_sh = false,
})
