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
	hint = [[
┌───────────────────────┐
│ < : Move vsplit left  │
│ > : Move vsplit right │
│ w :  Switch Split     │
└───────────────────────┘
   ]],
})

-- Need to fix, stepping commands don't work with debug & hydra?
Hydra({
	name = "Debugger Stack",
	mode = "n",
	body = "<leader>d",
	heads = {
		{ "u", ':lua require("dap").up()<CR>' },
		{ "d", ':lua require("dap").down()<CR>' },
	},
	hint = [[
┌────────────────┐
│ u : Up Stack   │
│ d : Down Stack │
└────────────────┘
]],
})

Hydra({
	name = "Treewalker",
	mode = "n",
	body = "<leader>w",
	heads = {
		{ "<Up>", "<cmd>Treewalker SwapUp<CR>" },
		{ "<Down>", "<cmd>Treewalker SwapDown<CR>" },
		{ "<Left>", "<cmd>Treewalker SwapLeft<CR>" },
		{ "<Right>", "<cmd>Treewalker SwapRight<CR>" },
	},
	hint = [[
┌───────────────────┐
│ Up   : Move Up    │
│ Down : Move Down  │
│ Left : Swap Left  │
│ Right: Swap Right │
└───────────────────┘
]],
})
