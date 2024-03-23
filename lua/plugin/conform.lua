require("conform").setup({
   formatters_by_ft = {
      css = { "prettierd" },
      javascript = { "prettierd" },
      html = { "prettierd" },
      python = { "isort", "black" },
   },

   format_on_save = {
      timeout_ms = 5000,
      lsp_fallback = true,
   },
})

