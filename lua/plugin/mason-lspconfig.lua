require('mason-lspconfig').setup({
   ensure_installed = { 'omnisharp', 'black', 'css-lsp', 'html-lsp', 'isort', 'lua-language-server', 'pylint', 'pyright',
      'typescript-language-server', 'vulture' },
})
