require('nvim-treesitter.configs').setup({
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = true, -- DISABLED DUE TO COMPATABILITY ISSUE WITH CURRENT NEOVIM VERSION, NEED TO TEST WITH FUTURE VERSIONS - https://github.com/p00f/nvim-ts-rainbow/issues/97
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	autotag = {
		enable = false,
	},
})
