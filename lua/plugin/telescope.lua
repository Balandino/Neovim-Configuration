local actions = require('telescope.actions')
require('telescope').setup({
	defaults = {
		mappings = {
			i = {
				['<C-z>'] = actions.select_vertical, -- Check mappings.lua for additional mappings.  Default of C-v reverts to paste in some terminals
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = false, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = 'smart_case', -- or "ignore_case" or "respect_case. The default case_mode is "smart_case"
		},
	},
})

require('telescope').load_extension('fzf')

-- Mappings for opening a new file
-- <C-x> go to file selection as a split
-- <C-z> go to file selection as a vsplit
-- <C-t> go to a file in a new tab
