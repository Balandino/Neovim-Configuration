local omnisharp_bin = 'C:/Users/Michael/AppData/Local/nvim-data/lsp_servers/omnisharp/omnisharp/OmniSharp.exe'
if vim.fn.empty(vim.fn.glob(omnisharp_bin)) == 0 then
	local pid = vim.fn.getpid()
	lsp.omnisharp.setup(coq.lsp_ensure_capabilities({
		cmd = {
			omnisharp_bin,
			'--languageserver',
			'--hostPID',
			tostring(pid),
		},
		on_attach = function(client)
			client.resolved_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
			client.resolved_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
		end,
	}))
end
