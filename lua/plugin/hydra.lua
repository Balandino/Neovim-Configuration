local Hydra = require('hydra')

Hydra({
	name = 'Window Resize',
	mode = 'n',
	body = '<C-w>',
	heads = {
		{ '<', '<C-w><' },
		{ '>', '<C-w>>' },
		{ 'w', '<C-w><C-w>' },
	},
})
