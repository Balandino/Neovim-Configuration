lsp.tsserver.setup(coq.lsp_ensure_capabilities({
	cmd = {
		'C:/Users/Michael/AppData/Local/nvim-data/lsp_servers/tsserver/node_modules/.bin/typescript-language-server.cmd',
		'--stdio',
	},
	-- on_attach = function(client)
	-- 	client.resolved_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
	-- 	client.resolved_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
	-- end,
}))

-- Autoformat using tsserver instead of clang via null-ls
vim.cmd('autocmd FileType javascript autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
