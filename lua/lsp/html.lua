lsp.html.setup(coq.lsp_ensure_capabilities({
	cmd = {
		'C:/Users/Michael/AppData/Local/nvim-data/lsp_servers/html/node_modules/.bin/vscode-html-language-server.cmd',
		'--stdio',
	},
}))

-- Autoformat using tsserver instead of clang via null-ls
vim.cmd('autocmd FileType html autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
