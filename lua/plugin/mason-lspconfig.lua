require("mason-lspconfig").setup()

-- Need to use installer plugin as non LSP files aren't recognised by Mason and so have to be handled manually or through a function
-- require("mason-lspconfig").setup {
-- ensure_installed = { "biome", "black", "cssls", "debugpy", "html", "inteliphense", "isort", "lua_ls", "prettierd", "pyright", "quick_lint_js", "stylua", "terraformls", "ts_ls" },

-- }
