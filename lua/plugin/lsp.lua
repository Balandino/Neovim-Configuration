local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

--[[
██╗░░░░░██╗░░░██╗░█████╗░
██║░░░░░██║░░░██║██╔══██╗
██║░░░░░██║░░░██║███████║
██║░░░░░██║░░░██║██╔══██║
███████╗╚██████╔╝██║░░██║
╚══════╝░╚═════╝░╚═╝░░╚═╝
-- https://fsymbols.com/generators/carty/
--]]

vim.lsp.config("lua_ls", {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			---@diagnostic disable-next-line: undefined-field
			if path ~= vim.fn.stdpath("config") and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using (most
				-- likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Tell the language server how to find Lua modules same way as Neovim
				-- (see `:h lua-module-load`)
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					-- Depending on the usage, you might want to add additional paths
					-- here.
					-- '${3rd}/luv/library',
					-- '${3rd}/busted/library',
				},
			},
		})
	end,
	settings = {
		Lua = {},
	},
})

vim.lsp.enable({ "lua_ls", "stylua" })

--[[
░██████╗██╗░░██╗███████╗██╗░░░░░██╗░░░░░
██╔════╝██║░░██║██╔════╝██║░░░░░██║░░░░░
╚█████╗░███████║█████╗░░██║░░░░░██║░░░░░
░╚═══██╗██╔══██║██╔══╝░░██║░░░░░██║░░░░░
██████╔╝██║░░██║███████╗███████╗███████╗
╚═════╝░╚═╝░░╚═╝╚══════╝╚══════╝╚══════╝
--]]

-- Needed to do this eay to enforce zsh instead of the simple enable command which doesn't
-- Also included capabilities in case useful
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sh", "bash", "zsh" },
	callback = function()
		vim.lsp.start({
			capabilities = cmp_capabilities,
			name = "bashls",
			cmd = { "bash-language-server", "start" },
			root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
		})
	end,
})

--[[
░██████╗░░█████╗░
██╔════╝░██╔══██╗
██║░░██╗░██║░░██║
██║░░╚██╗██║░░██║
╚██████╔╝╚█████╔╝
░╚═════╝░░╚════╝░
--]]

-- Done this way so capabilities could be included
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.lsp.start({
			name = "gopls",
			cmd = { "gopls" },
			root_dir = vim.fs.root(0, { "go.mod", ".git" }),
			capabilities = cmp_capabilities,
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
				},
			},
		})
	end,
})

--[[
██╗░░██╗████████╗███╗░░░███╗██╗░░░░░  ░░░░░░░  ░█████╗░░██████╗░██████╗
██║░░██║╚══██╔══╝████╗░████║██║░░░░░  ░░██╗░░  ██╔══██╗██╔════╝██╔════╝
███████║░░░██║░░░██╔████╔██║██║░░░░░  ██████╗  ██║░░╚═╝╚█████╗░╚█████╗░
██╔══██║░░░██║░░░██║╚██╔╝██║██║░░░░░  ╚═██╔═╝  ██║░░██╗░╚═══██╗░╚═══██╗
██║░░██║░░░██║░░░██║░╚═╝░██║███████╗  ░░╚═╝░░  ╚█████╔╝██████╔╝██████╔╝
╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░░░╚═╝╚══════╝  ░░░░░░░  ░╚════╝░╚═════╝░╚═════╝░
--]]

vim.lsp.enable({ "html", "cssls" })

--[[
░░░░░██╗░█████╗░██╗░░░██╗░█████╗░░██████╗░█████╗░██████╗░██╗██████╗░████████╗
░░░░░██║██╔══██╗██║░░░██║██╔══██╗██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝
░░░░░██║███████║╚██╗░██╔╝███████║╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░
██╗░░██║██╔══██║░╚████╔╝░██╔══██║░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░
╚█████╔╝██║░░██║░░╚██╔╝░░██║░░██║██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░
░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░
--]]

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	callback = function()
		local root = vim.fs.root(0, {
			"package.json",
			"tsconfig.json",
			"jsconfig.json",
			".git",
		})

		-- ts_ls (TypeScript Language Server)
		vim.lsp.start({
			name = "ts_ls",
			cmd = { "typescript-language-server", "--stdio" },
			root_dir = root,
			capabilities = cmp_capabilities,
		})

		-- biome
		vim.lsp.start({
			name = "biome",
			cmd = { "biome", "lsp-proxy" },
			root_dir = root,
			capabilities = cmp_capabilities,
		})

		-- quick-lint-js
		vim.lsp.start({
			name = "quick_lint_js",
			cmd = { "quick-lint-js", "--lsp-server" },
			root_dir = root,
			capabilities = cmp_capabilities,
		})
	end,
})

vim.api.nvim_create_user_command("ChromeStartDebug", "!start chrome.exe --remote-debugging-port=9222", { nargs = 0, bang = true })

--[[
░░░░░██╗░██████╗░█████╗░███╗░░██╗
░░░░░██║██╔════╝██╔══██╗████╗░██║
░░░░░██║╚█████╗░██║░░██║██╔██╗██║
██╗░░██║░╚═══██╗██║░░██║██║╚████║
╚█████╔╝██████╔╝╚█████╔╝██║░╚███║
░╚════╝░╚═════╝░░╚════╝░╚═╝░░╚══╝
--]]

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("jsonls", {
	capabilities = capabilities,
})

vim.lsp.enable("jsonls")

-- --[[
-- ██╗░░░░░░█████╗░████████╗███████╗██╗░░██╗
-- ██║░░░░░██╔══██╗╚══██╔══╝██╔════╝╚██╗██╔╝
-- ██║░░░░░███████║░░░██║░░░█████╗░░░╚███╔╝░
-- ██║░░░░░██╔══██║░░░██║░░░██╔══╝░░░██╔██╗░
-- ███████╗██║░░██║░░░██║░░░███████╗██╔╝╚██╗
-- ╚══════╝╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═╝░░╚═╝
-- --]]

-- Untested
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "tex", "plaintex", "latex" },
	callback = function()
		local root = vim.fs.root(0, { "texlab.toml", ".git", ".latexmkrc", "main.tex" })
		vim.lsp.start({
			name = "texlab",
			cmd = { "texlab" },
			root_dir = root,
			capabilities = cmp_capabilities,
			settings = {
				texlab = {
					auxDirectory = ".",
					bibtexFormatter = "texlab",
					build = { args = { "-shell-escape", "%f" }, executable = "pdflatex", forwardSearchAfter = false, onSave = true },
					chktex = { onEdit = true, onOpenAndSave = true },
					diagnosticsDelay = 300,
					formatterLineLength = 80,
					forwardSearch = { executable = "zathura", args = { "-reuse-instance", "%p", "-forward-search", "%f", "%l" }, onSave = true },
					latexFormatter = "latexindent",
					latexindent = { modifyLineBreaks = false },
				},
			},
		})
	end,
})

-- Untested
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "tex", "plaintex", "text" },
	callback = function()
		local root = vim.fs.root(0, { ".git", "ltex.conf" })

		vim.lsp.start({
			name = "ltex",
			cmd = { "ltex-ls" },
			root_dir = root,
			capabilities = cmp_capabilities,
		})
	end,
})

-- Had to rename .cmd in nvim-data to .bat and start this way as autostart did not work
-- vim.api.nvim_create_augroup("latex", { clear = true })
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	group = "latex",
-- 	pattern = "*",
-- 	callback = function()
-- 		local extension = vim.bo.filetype
--
-- 		for _, value in pairs({ "tex" }) do
-- 			if value == extension then
-- 				vim.cmd("LspStart ltex")
-- 				break
-- 			end
-- 		end
-- 	end,
-- })

--[[
░█████╗░░░░░██╗░█████╗░░░░░░░░░░░░░░░
██╔══██╗░░░██╔╝██╔══██╗░░██╗░░░░██╗░░
██║░░╚═╝░░██╔╝░██║░░╚═╝██████╗██████╗
██║░░██╗░██╔╝░░██║░░██╗╚═██╔═╝╚═██╔═╝
╚█████╔╝██╔╝░░░╚█████╔╝░░╚═╝░░░░╚═╝░░
░╚════╝░╚═╝░░░░░╚════╝░░░░░░░░░░░░░░░
--]]

-- Needed to do this eay to enforce zsh instead of the simple enable command which doesn't
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function()
		vim.lsp.start({
			name = "clangd",
			cmd = {
				"clangd",
				"--background-index",
				"--suggest-missing-includes",
				"--pch-storage=memory",
				"--clang-tidy",
				"--completion-style=detailed",
			},
			root_dir = vim.fs.dirname(
				vim.fs.find({ ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" }, { upward = true })[1]
			),
		})
	end,
})

--[[
████████╗███████╗██████╗░██████╗░░█████╗░███████╗░█████╗░██████╗░███╗░░░███╗
╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░████║
░░░██║░░░█████╗░░██████╔╝██████╔╝███████║█████╗░░██║░░██║██████╔╝██╔████╔██║
░░░██║░░░██╔══╝░░██╔══██╗██╔══██╗██╔══██║██╔══╝░░██║░░██║██╔══██╗██║╚██╔╝██║
░░░██║░░░███████╗██║░░██║██║░░██║██║░░██║██║░░░░░╚█████╔╝██║░░██║██║░╚═╝░██║
░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝
--]]

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "terraform", "hcl" },
	callback = function()
		local root = vim.fs.root(0, { ".terraform", ".git", "*.tf" })

		vim.lsp.start({
			name = "terraformls",
			cmd = { "terraform-ls", "serve" },
			root_dir = root,
			capabilities = cmp_capabilities,
		})

		vim.lsp.start({
			name = "tflint",
			cmd = { "tflint", "--langserver" },
			root_dir = root,
			capabilities = cmp_capabilities,
		})
	end,
})

--[[
██████╗░██╗░░░██╗████████╗██╗░░██╗░█████╗░███╗░░██╗
██╔══██╗╚██╗░██╔╝╚══██╔══╝██║░░██║██╔══██╗████╗░██║
██████╔╝░╚████╔╝░░░░██║░░░███████║██║░░██║██╔██╗██║
██╔═══╝░░░╚██╔╝░░░░░██║░░░██╔══██║██║░░██║██║╚████║
██║░░░░░░░░██║░░░░░░██║░░░██║░░██║╚█████╔╝██║░╚███║
╚═╝░░░░░░░░╚═╝░░░░░░╚═╝░░░╚═╝░░╚═╝░╚════╝░╚═╝░░╚══╝
--]]

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python" },
	callback = function()
		local root = vim.fs.root(0, {
			".pylintrc",
			"pyrightconfig.json",
			"pyproject.toml",
			"setup.py",
			".git",
		})

		-- Start Pyright
		vim.lsp.start({
			name = "pyright",
			cmd = { "pyright-langserver", "--stdio" },
			root_dir = root,
			capabilities = cmp_capabilities,
		})

		-- Start Ruff LSP
		vim.lsp.start({
			name = "ruff",
			cmd = { "ruff", "server" },
			root_dir = root,
			capabilities = cmp_capabilities,
			init_options = {
				settings = {
					fix = false, -- Turn off, conform uses ruff for formatting
				},
			},
		})
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
	lintStdin = true,
	lintFormats = {
		"%f:%l:%c: %trror: %m",
		"%f:%l:%c: %tarning: %m",
		"%f:%l:%c: %tote: %m",
	},
	prefix = "mypy",
}

local pylint = {
	lintCommand = "pylint --score=no ${INPUT}",
	-- lintCommand = "pylint --score=no ${INPUT} --disable=E0401",
	lintStdin = true,
	lintFormats = { "%.%#:%l:%c: %t%.%#: %m" },
	prefix = "pylint",
}

local flake8 = {
	-- lintCommand = "flake8 - --max-line-length 100",
	lintCommand = "flake8 - --ignore=E501,F401,F841,W503,W391,E203",
	lintStdin = true,
	lintFormats = { "stdin:%l:%c: %t%n %m" },
	rootMarkers = { "setup.cfg", "tox.ini", ".flake8" },
	prefix = "flake8",
}

local vulture = {
	lintCommand = "vulture --min-confidence 61 ${INPUT}",
	lintStdin = true,
	lintFormats = { "%f:%l: %m" },
	prefix = "vulture",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python" },
	callback = function()
		local root = vim.fs.root(0, { ".git", "pyvenv.cfg" })
		vim.lsp.start({
			name = "efm",
			cmd = { "efm-langserver" },
			root_dir = root,
			capabilities = cmp_capabilities,
			init_options = {
				documentFormatting = false,
				documentRangeFormatting = false,
				hover = true,
				documentSymbol = true,
				codeAction = true,
				completion = true,
			},
			settings = { rootMarkers = { ".git", "pyvenv.cfg" }, languages = { python = { mypy, pylint, flake8, vulture } } },
		})
	end,
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

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	group = "formatting",
-- 	pattern = "*",
-- 	callback = function()
-- 		local extension = vim.bo.filetype
--
-- 		for _, value in pairs({ "c", "cpp", "typescript",  "java", "json", "javascript" }) do
-- 			if value == extension then
-- 				vim.lsp.buf.format()
-- 				break
-- 			end
-- 		end
-- 	end,
-- })
--

-- Rome causes terminal to hang due to leftover daemon
vim.api.nvim_create_autocmd("VimLeave", {
	group = "formatting",
	pattern = "*",
	callback = function()
		if vim.bo.filetype == "javascript" then
			vim.cmd("silent exec '!biome stop'")
		end
	end,
})
