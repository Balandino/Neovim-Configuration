local Hydra = require("hydra")

Hydra({
	name = "Window Resize",
	mode = "n",
	body = "<C-w>",
	heads = {
		{ "<", "<C-w><" },
		{ ">", "<C-w>>" },
		{ "w", "<C-w><C-w>" },
	},
})

Hydra({
	name = "Debugger Stack",
	mode = "n",
	body = "<leader>d",
	heads = {
		{ "u", ':lua require("dap").up()<CR>' },
		{ "d", ':lua require("dap").down()<CR>' },
		{ "i", ':lua require("dap").step_into()<CR>' },
		{ "o", ':lua require("dap").step_over()<CR>' },
		{ "t", ':lua require("dap").step_out()<CR>' },
		{ "c", ':lua require("dap").run_to_cursor()<CR>' },
		{ "t", ':lua require("dap").step_out()<CR>' },
	},
})
