lsp.jedi_language_server.setup(coq.lsp_ensure_capabilities({
   cmd = {
      'jedi-language-server',
   },
   cmd_env = { VIRTUAL_ENV = 'C:\\Coding\\Workpad\\Python\\C:\\Coding\\Workpad\\PythonTesterVirtual\\pyvenv.cfg' },
   filetypes = { 'python' },
   single_file_support = true,
   on_attach = function(client)
      client.server_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
      client.server_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
   end,
}))

lsp.jedi_language_server.setup(coq.lsp_ensure_capabilities({}))
