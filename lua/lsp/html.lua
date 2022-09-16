lsp.html.setup(coq.lsp_ensure_capabilities({}))

-- Autoformat using tsserver instead of clang via null-ls
vim.cmd('autocmd FileType html autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
