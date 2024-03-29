require('transparent').setup({
	enable = true, -- boolean: enable transparent
	extra_groups = { -- table/string: additional groups that should be clear
		-- In particular, when you set it to 'all', that means all available groups
		'BufferLineTabClose',
		'BufferlineBufferSelected',
		'BufferLineFill',
		'BufferLineBackground',
		'BufferLineSeparator',
		'BufferLineIndicatorSelected',
		'all',
	},
	exclude = {}, -- table: groups you don't want to clear
})
