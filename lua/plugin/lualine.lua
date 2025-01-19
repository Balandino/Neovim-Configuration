local function getLsps()
   local lspNames = "["
   for _, client in pairs(vim.lsp.get_clients()) do
      lspNames = lspNames .. client.name .. ", "
   end

   return string.sub(lspNames, 1, string.len(lspNames) - 2) .. "]"
end

local function getTotalLines()
   return vim.fn.line("$")
end

local diagnostics = {
   "diagnostics",
   sources = { "nvim_diagnostic", "nvim_lsp", "nvim_workspace_diagnostic", "vim_lsp" },
   sections = { "error", "warn", "info", "hint" },
   symbols = {
      error = "E",
      hint = "H",
      info = "I",
      warn = "W",
   },
   colored = true,
   update_in_insert = false,
   always_visible = true,
}


local gruvbox_theme = require("lualine.themes.gruvbox")
local custom_gruvbox = { normal = {}, insert = {}, visual = {}, replace = {}, command = {}, inactive = {} }
custom_gruvbox.normal.a = { bg = "None", fg = gruvbox_theme.light4, gui = "bold" }
custom_gruvbox.normal.b = { bg = "None", fg = gruvbox_theme.light4 }
custom_gruvbox.normal.c = { bg = "None", fg = gruvbox_theme.light4 }

custom_gruvbox.insert.a = { bg = "None", fg = gruvbox_theme.bright_blue, gui = "bold" }
custom_gruvbox.insert.b = { bg = "None", fg = gruvbox_theme.light4 }
custom_gruvbox.insert.c = { bg = "None", fg = gruvbox_theme.light4 }

custom_gruvbox.visual.a = { bg = "None", fg = gruvbox_theme.bright_yellow, gui = "bold" }
custom_gruvbox.visual.b = { bg = "None", fg = gruvbox_theme.light4 }
custom_gruvbox.visual.c = { bg = "None", fg = gruvbox_theme.light4 }

custom_gruvbox.replace.a = { bg = "RED", fg = gruvbox_theme.bright_red, gui = "bold" }
custom_gruvbox.replace.b = { bg = "None", fg = gruvbox_theme.light4 }
custom_gruvbox.replace.c = { bg = "None", fg = gruvbox_theme.light4 }

custom_gruvbox.command.a = { bg = "None", fg = gruvbox_theme.bright_green, gui = "bold" }
custom_gruvbox.command.b = { bg = "None", fg = gruvbox_theme.light4 }
custom_gruvbox.command.c = { bg = "None", fg = gruvbox_theme.light4 }

custom_gruvbox.inactive.a = { bg = "None", fg = gruvbox_theme.light4, gui = "bold" }
custom_gruvbox.inactive.b = { bg = "None", fg = gruvbox_theme.light4 }
custom_gruvbox.inactive.c = { bg = "None", fg = gruvbox_theme.light4 }


require("lualine").setup({
   options = {
      icons_enabled = true,
      theme = custom_gruvbox,
      -- theme = "gruvbox",
      component_separators = { "", "" },
      section_separators = { "", "" },
      disabled_filetypes = {},
   },

   sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { "filename", diagnostics },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { getLsps },
      lualine_z = { "location", "progress", getTotalLines },
   },

   inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
   },

   tabline = {
   },
})
