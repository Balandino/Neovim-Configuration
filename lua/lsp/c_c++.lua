lsp.clangd.setup(coq.lsp_ensure_capabilities({
	cmd = {
		'clangd',
		'--background-index',
		'--suggest-missing-includes',
	},
	filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
		client.resolved_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
	end,
}))
