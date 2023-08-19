require("neodev").setup()

-- Set up lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp = require("lspconfig")

--[[
██╗░░░░░██╗░░░██╗░█████╗░
██║░░░░░██║░░░██║██╔══██╗
██║░░░░░██║░░░██║███████║
██║░░░░░██║░░░██║██╔══██║
███████╗╚██████╔╝██║░░██║
╚══════╝░╚═════╝░╚═╝░░╚═╝
-- https://fsymbols.com/generators/carty/
--]]

lsp.lua_ls.setup({
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- Stop question appearing
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
	format = {
		enable = false,
	},
	on_attach = function(client)
		client.server_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
		client.server_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
	end,
})

--[[
██████╗░██╗░░██╗██████╗░
██╔══██╗██║░░██║██╔══██╗
██████╔╝███████║██████╔╝
██╔═══╝░██╔══██║██╔═══╝░
██║░░░░░██║░░██║██║░░░░░
╚═╝░░░░░╚═╝░░╚═╝╚═╝░░░░░
--]]

lsp.intelephense.setup({
	capabilities = capabilities,
})

--[[

██╗░░██╗████████╗███╗░░░███╗██╗░░░░░
██║░░██║╚══██╔══╝████╗░████║██║░░░░░
███████║░░░██║░░░██╔████╔██║██║░░░░░
██╔══██║░░░██║░░░██║╚██╔╝██║██║░░░░░
██║░░██║░░░██║░░░██║░╚═╝░██║███████╗
╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░░░╚═╝╚══════╝
--]]

lsp.html.setup({
	capabilities = capabilities,
})

--[[
░█████╗░░██████╗░██████╗
██╔══██╗██╔════╝██╔════╝
██║░░╚═╝╚█████╗░╚█████╗░
██║░░██╗░╚═══██╗░╚═══██╗
╚█████╔╝██████╔╝██████╔╝
░╚════╝░╚═════╝░╚═════╝░
--]]

lsp.cssls.setup({
	capabilities = capabilities,
})

--[[
░░░░░██╗░█████╗░██╗░░░██╗░█████╗░░██████╗░█████╗░██████╗░██╗██████╗░████████╗
░░░░░██║██╔══██╗██║░░░██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝
░░░░░██║███████║╚██╗░██╔╝███████║╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░
██╗░░██║██╔══██║░╚████╔╝░██╔══██║░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░
╚█████╔╝██║░░██║░░╚██╔╝░░██║░░██║██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░
░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░
--]]

lsp.tsserver.setup({
	capabilities = capabilities,
})

lsp.rome.setup({
	capabilities = capabilities,
})

vim.api.nvim_create_user_command("RomeFix", "!rome check --apply %", { nargs = 0, bang = true })
vim.api.nvim_create_user_command("RomeFixUnsafe", "!rome check --apply-unsafe %", { nargs = 0, bang = true })

--[[
░░░░░██╗░██████╗░█████╗░███╗░░██╗
░░░░░██║██╔════╝██╔══██╗████╗░██║
░░░░░██║╚█████╗░██║░░██║██╔██╗██║
██╗░░██║░╚═══██╗██║░░██║██║╚████║
╚█████╔╝██████╔╝╚█████╔╝██║░╚███║
░╚════╝░╚═════╝░░╚════╝░╚═╝░░╚══╝
--]]

local json_capabilities = require("cmp_nvim_lsp").default_capabilities()
json_capabilities.textDocument.completion.completionItem.snippetSupport = true

require("lspconfig").jsonls.setup({
	capabilities = json_capabilities,
})

--[[
██████╗░██╗░░░██╗████████╗██╗░░██╗░█████╗░███╗░░██╗
██╔══██╗╚██╗░██╔╝╚══██╔══╝██║░░██║██╔══██╗████╗░██║
██████╔╝░╚████╔╝░░░░██║░░░███████║██║░░██║██╔██╗██║
██╔═══╝░░░╚██╔╝░░░░░██║░░░██╔══██║██║░░██║██║╚████║
██║░░░░░░░░██║░░░░░░██║░░░██║░░██║╚█████╔╝██║░╚███║
╚═╝░░░░░░░░╚═╝░░░░░░╚═╝░░░╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝
--]]

lsp.pyright.setup({
	capabilities = capabilities,
})

-- Mason doesn't work at the moment, can't install
-- lsp.jedi_language_server.setup({
-- 	capabilities = capabilities,
-- })

--[[
░█████╗░░░░░██╗░█████╗░░░░░░░░░░░░░░░
██╔══██╗░░░██╔╝██╔══██╗░░██╗░░░░██╗░░
██║░░╚═╝░░██╔╝░██║░░╚═╝██████╗██████╗
██║░░██╗░██╔╝░░██║░░██╗╚═██╔═╝╚═██╔═╝
╚█████╔╝██╔╝░░░╚█████╔╝░░╚═╝░░░░╚═╝░░
░╚════╝░╚═╝░░░░░╚════╝░░░░░░░░░░░░░░░
--]]

lsp.clangd.setup({
	cmd = {
		"clangd",
		"--background-index",
		"--suggest-missing-includes",
		"--pch-storage=memory",
		"--clang-tidy",
		"--completion-style=detailed",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
	on_attach = function(client)
		-- client.server_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
		-- client.server_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
		client.offsetEncoding = "utf-8"
	end,
})

--[[
███████╗███████╗███╗░░░███╗  ██╗░░░░░░██████╗██████╗░
██╔════╝██╔════╝████╗░████║  ██║░░░░░██╔════╝██╔══██╗
█████╗░░█████╗░░██╔████╔██║  ██║░░░░░╚█████╗░██████╔╝
██╔══╝░░██╔══╝░░██║╚██╔╝██║  ██║░░░░░░╚═══██╗██╔═══╝░
███████╗██║░░░░░██║░╚═╝░██║  ███████╗██████╔╝██║░░░░░
╚══════╝╚═╝░░░░░╚═╝░░░░░╚═╝  ╚══════╝╚═════╝░╚═╝░░░░░
--]]

-- Configs pulled and modified from: https://github.com/creativenull/efmls-configs-nvim

local mypy = {
	lintCommand = "mypy ${INPUT} --show-column-numbers --ignore-missing-imports --show-error-codes",
	-- lintCommand = "mypy % --show-column-numbers --ignore-missing-imports --show-error-codes",
	lintStdin = true,
	lintFormats = {
		"%f:%l:%c: %trror: %m",
		"%f:%l:%c: %tarning: %m",
		"%f:%l:%c: %tote: %m",
	},
	-- lintSource = "mypy", -- Not needed?
}

local pylint = {
	lintCommand = "pylint --score=no ${INPUT}",
	lintStdin = true,
	lintFormats = { "%.%#:%l:%c: %t%.%#: %m" },
}

local flake8 = {
	lintCommand = "flake8 -",
	lintStdin = true,
	lintFormats = { "stdin:%l:%c: %t%n %m" },
	-- rootMarkers = { 'setup.cfg', 'tox.ini', '.flake8' },
}

local vulture = {
	lintCommand = "vulture --min-confidence 61 ${INPUT}",
	lintStdin = true,
	lintFormats = { "%f:%l: %m" },
}

lsp.efm.setup({
	init_options = {
		documentFormatting = false,
		documentRangeFormatting = false,
		hover = true,
		documentSymbol = true,
		codeAction = true,
		completion = true,
	},
	settings = {
		rootMarkers = { ".git/", "fmp.py" }, -- Needs to be accurate for emf to properly workm even if it loads it won't work if not correct
		languages = {
			python = {
				mypy,
				pylint,
				flake8,
				vulture,
			},
		},
	},
	filetypes = { "python" },
})

--[[
███████╗░█████╗░██████╗░███╗░░░███╗░█████╗░████████╗████████╗██╗███╗░░██╗░██████╗░
██╔════╝██╔══██╗██╔══██╗████╗░████║██╔══██╗╚══██╔══╝╚══██╔══╝██║████╗░██║██╔════╝░
█████╗░░██║░░██║██████╔╝██╔████╔██║███████║░░░██║░░░░░░██║░░░██║██╔██╗██║██║░░██╗░
██╔══╝░░██║░░██║██╔══██╗██║╚██╔╝██║██╔══██║░░░██║░░░░░░██║░░░██║██║╚████║██║░░╚██╗
██║░░░░░╚█████╔╝██║░░██║██║░╚═╝░██║██║░░██║░░░██║░░░░░░██║░░░██║██║░╚███║╚██████╔╝
╚═╝░░░░░░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░╚═╝╚═╝░░╚══╝░╚═════╝░
--]]

-- Formatting Auto Commands
vim.api.nvim_create_augroup("formatting", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	group = "formatting",
	pattern = "*",
	callback = function()
		local extension = vim.bo.filetype

		for _, value in pairs({ "c", "cpp", "typescript", "php", "java", "json", "javascript" }) do
			if value == extension then
				vim.lsp.buf.format()
				break
			end
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = "formatting",
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "python" then
			vim.cmd("silent exec '!isort %'")
		end
	end,
})

-- Rome causes terminal to hang due to leftover daemon
vim.api.nvim_create_autocmd("VimLeavePre", {
	group = "formatting",
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "javascript" then
			vim.cmd("silent exec '!rome stop'")
		end
	end,
})
