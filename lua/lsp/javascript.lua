lsp.tsserver.setup(coq.lsp_ensure_capabilities({}))

-- Autoformat using tsserver instead of clang via null-ls
vim.cmd('autocmd FileType javascript autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
