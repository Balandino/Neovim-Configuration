lsp.clangd.setup(coq.lsp_ensure_capabilities({
   cmd = {
      'clangd',
      '--background-index',
      '--suggest-missing-includes',
      '--pch-storage=memory',
      '--clang-tidy',
      '--completion-style=detailed',
   },
   filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
   on_attach = function(client)
      client.server_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
      client.server_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
      client.offsetEncoding = 'utf-8'
   end,
}))
