-- lsp.jedi_language_server.setup(coq.lsp_ensure_capabilities({
-- 	cmd = {
-- 		'jedi-language-server',
-- 	},
-- 	filetypes = { 'python' },
-- 	single_file_support = true,
-- 	on_attach = function(client)
-- 		client.resolved_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
-- 		client.resolved_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
-- 	end,
-- }))
--

lsp.jedi_language_server.setup(coq.lsp_ensure_capabilities({}))
