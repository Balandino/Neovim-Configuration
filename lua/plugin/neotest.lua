require('neotest').setup({
	adapters = {
		require('neotest-python')({
			runner = 'unittest',
			python = 'python',
		}),
	},
})
