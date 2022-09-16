require('mason-lspconfig').setup({
	ensure_installed = { 'omnisharp', 'clang-format', 'clangd', 'black', 'css-lsp', 'html-lsp', 'isort', 'lua-language-server', 'pylint', 'pyright', 'typescript-language-server', 'vulture' },
})
