require("conform").setup({
   formatters_by_ft = {
      css = { "prettierd" },
      javascript = { "prettierd" },
      html = { "prettierd" },
      python = { "isort", "black" },
   },
   notify_on_error = true,
   formatters = {
      isort = {
         include_trailing_comma = true,
         command = "isort",
         args = {
            "--line-length",
            "120",
            "--lines-after-import",
            "2",
            "--quiet",
            "-",
         },
      },
      black = {
         command = "black",
         args = {
            "--line-length",
            "120",
            "--quiet",
            "-",
         }
      }
   },

   format_on_save = {
      timeout_ms = 5000,
      lsp_fallback = true,
   },
})
