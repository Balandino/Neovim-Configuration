local actions_state = require("telescope.actions.state")
local actions = require("telescope.actions")

local print_selected_entry = function(prompt_bufnr)
   local command = "Fe " .. actions_state.get_selected_entry()[1]
   actions.close(prompt_bufnr)
   vim.cmd(command)
end

-- local actions = require("telescope.actions")
require("telescope").setup({
   defaults = {
      mappings = {
         i = {
            ["<C-z>"] = actions.select_vertical, -- Check mappings.lua for additional mappings.  Default of C-v reverts to paste in some terminals
            ["<C-f>"] = print_selected_entry, -- Check mappings.lua for additional mappings.
         },
      },
   },
   extensions = {
      fzf = {
         fuzzy = false,            -- false will only do exact matching
         override_generic_sorter = true, -- override the generic sorter
         override_file_sorter = true, -- override the file sorter
         case_mode = "smart_case", -- or "ignore_case" or "respect_case. The default case_mode is "smart_case"
      },
      -- ["ui-select"] = {
      -- 	require("telescope.themes").get_dropdown({}),
      -- },
   },
})

require("telescope").load_extension("fzf")
-- require("telescope").load_extension("ui-select")

-- Mappings for opening a new file
-- <C-x> go to file selection as a split
-- <C-z> go to file selection as a vsplit
-- <C-t> go to a file in a new tab
