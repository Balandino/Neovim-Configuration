require("conform").setup({
	formatters_by_ft = {
		css = { "prettierd" },
		javascript = { "prettierd" },
		html = { "prettierd" },
		python = { "ruff_organize_imports", "ruff_format" },
		terraform = { "terraform_fmt" },
		lua = { "stylua" },
	},

	notify_on_error = true,
	format_on_save = false,

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = { "*.css", "*.js", "*.html", "*.py", "*.tf", "*.lua" },
		callback = function(args)
			require("conform").format({
				bufnr = args.buf,
				lsp_fallback = false, -- Avoid to prevent cursor jumping
				async = false, -- Avoid to prevent cursor jumping
			})
		end,
	}),
})
