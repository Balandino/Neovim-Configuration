-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
-- Keymappings
-------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------
-- Some General
-------------------------------------------------------------------------------------------------------------------------------
-- Alt escape
vim.keymap.set("n", "<M-m>", "<Esc>")

-- Alternative quit
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")

-- Copy entire file to system clipboard
vim.keymap.set("n", "<F2>", "<cmd>%y+<CR>")

-- Replace entire file with register r, then paste into system clipboard
vim.keymap.set("n", "<F12>", 'gg0"rdGgg0"*p"<CR>')

-------------------------------------------------------------------------------------------------------------------------------
-- Buffer Switch
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<C-k>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>bprevious<CR>")

-------------------------------------------------------------------------------------------------------------------------------
-- Terminal Mode
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>")

-------------------------------------------------------------------------------------------------------------------------------
-- Hop
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set({ "n", "v" }, "s", "<cmd>HopChar2MW<CR>")
vim.keymap.set({ "n", "v" }, "S", "<cmd>HopChar1MW<CR>")
vim.keymap.set({ "n", "v" }, "f", "<cmd>HopChar1CurrentLine<CR>")
vim.keymap.set({ "n", "v" }, "F", "<cmd>HopLineMW<CR>")
vim.keymap.set({ "n", "v" }, ";", "<cmd>HopLineStartMW<CR>")
vim.keymap.set({ "n", "v" }, "gs", "<cmd>HopLineMW<CR>")
vim.keymap.set({ "n", "v" }, "<leader>s", "<cmd>HopWordMW<CR>")

-------------------------------------------------------------------------------------------------------------------------------
-- Treewalker
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set({ "n", "v" }, "<S-Up>", "<cmd>Treewalker Up<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Down>", "<cmd>Treewalker Down<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Left>", "<cmd>Treewalker Left<cr>", { silent = true })
vim.keymap.set({ "n", "v" }, "<S-Right>", "<cmd>Treewalker Right<cr>", { silent = true })

-------------------------------------------------------------------------------------------------------------------------------
-- Snipe
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>s", require("snipe").open_buffer_menu)

-------------------------------------------------------------------------------------------------------------------------------
-- Boolean Flip
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "cf", function()
	FlipBoolean()
end)

-------------------------------------------------------------------------------------------------------------------------------
-- Neogen
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>nf", "<cmd>Neogen func<CR>")

-------------------------------------------------------------------------------------------------------------------------------
-- Telescope
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end)
vim.keymap.set("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end)
vim.keymap.set("n", "<leader>fd", function()
	require("telescope.builtin").diagnostics()
end)
vim.keymap.set("n", "<leader>fv", function()
	require("telescope.builtin").vim_options()
end)
vim.keymap.set("n", "<leader>flg", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end)
vim.keymap.set("n", "<leader>fll", function()
	require("telescope.builtin").lsp_document_symbols()
end)

-- Find functions only
vim.keymap.set("n", "<leader>flf", function()
	require("telescope.builtin").lsp_document_symbols({ symbols = "function" })
end)

-- Word under cursor in open buffers
vim.keymap.set("n", "<leader>fs", function()
	require("telescope.builtin").grep_string({ grep_open_files = true, only_sort_text = true })
end)

-- Live grep in open buffers
vim.keymap.set("n", "<leader>fg", function()
	require("telescope.builtin").live_grep({ grep_open_files = true, only_sort_text = true })
end)

-- Word under cursor in whole project
vim.keymap.set("n", "<leader>fes", function()
	require("telescope.builtin").grep_string({ only_sort_text = true })
end)

-- Live grep in whole project
vim.keymap.set("n", "<leader>feg", function()
	require("telescope.builtin").live_grep({ only_sort_text = true })
end)

vim.keymap.set("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end)
vim.keymap.set("n", "<leader>fgc", function()
	require("telescope.builtin").git_bcommits()
end)

-------------------------------------------------------------------------------------------------------------------------------
-- Trouble
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>t", "<cmd>Trouble diagnostics toggle<CR>")

-------------------------------------------------------------------------------------------------------------------------------
-- Neotest
-------------------------------------------------------------------------------------------------------------------------------
-- Toggle summary
vim.keymap.set("n", "<leader>us", function()
	require("neotest").summary.toggle()
end)

-- Run nearest test
vim.keymap.set("n", "<leader>ur", function()
	require("neotest").run.run()
end)

-- Toggle output panel
vim.keymap.set("n", "<leader>uo", function()
	require("neotest").output_panel.toggle()
end)

-- Run tests in current file
vim.keymap.set("n", "<leader>uf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end)

-------------------------------------------------------------------------------------------------------------------------------
-- Lazy
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>")
vim.keymap.set("n", "<leader>lp", "<cmd>Lazy profile<CR>")

-------------------------------------------------------------------------------------------------------------------------------
-- Debugging
-------------------------------------------------------------------------------------------------------------------------------
-- Toggle UI
vim.keymap.set("n", "<leader><F5>", function()
	require("dapui").toggle()
end)

-- Core stepping / running
vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end)
vim.keymap.set("n", "<F6>", function()
	require("dap").toggle_breakpoint()
end)
vim.keymap.set("n", "<F7>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<F8>", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<leader><F8>", function()
	require("dap").step_over()
end)

-- Widgets
vim.keymap.set("n", "<leader>ds", function()
	require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes)
end)

vim.keymap.set("n", "<leader>dv", function()
	require("dap.ui.widgets").hover()
end)

vim.keymap.set("n", "<leader>df", function()
	require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames)
end)

-- Stack navigation
vim.keymap.set("n", "<leader>du", function()
	require("dap").up()
end)
vim.keymap.set("n", "<leader>dd", function()
	require("dap").down()
end)

-- Stepping
vim.keymap.set("n", "<leader>dsi", function()
	require("dap").step_into()
end)
vim.keymap.set("n", "<leader>dso", function()
	require("dap").step_over()
end)
vim.keymap.set("n", "<leader>dst", function()
	require("dap").step_out()
end)

-- Run to cursor
vim.keymap.set("n", "<leader>drc", function()
	require("dap").run_to_cursor()
end)

-- Clear breakpoints
vim.keymap.set("n", "<leader>dcb", function()
	require("dap").clear_breakpoints()
end)

-------------------------------------------------------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gn", vim.lsp.buf.rename)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action)

vim.keymap.set("n", "<leader>j", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<leader>k", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })

-------------------------------------------------------------------------------------------------------------------------------
-- Neominimap
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>mm", "<cmd>Neominimap Toggle<CR>", { desc = "Toggle global minimap" })
vim.keymap.set("n", "<leader>mo", "<cmd>Neominimap Enable<CR>", { desc = "Enable global minimap" })
vim.keymap.set("n", "<leader>mc", "<cmd>Neominimap Disable<CR>", { desc = "Disable global minimap" })
vim.keymap.set("n", "<leader>mr", "<cmd>Neominimap Refresh<CR>", { desc = "Refresh global minimap" })

-- Window-Specific Minimap Controls
vim.keymap.set("n", "<leader>mwt", "<cmd>Neominimap WinToggle<CR>", { desc = "Toggle minimap for current window" })
vim.keymap.set("n", "<leader>mwr", "<cmd>Neominimap WinRefresh<CR>", { desc = "Refresh minimap for current window" })
vim.keymap.set("n", "<leader>mwo", "<cmd>Neominimap WinEnable<CR>", { desc = "Enable minimap for current window" })
vim.keymap.set("n", "<leader>mwc", "<cmd>Neominimap WinDisable<CR>", { desc = "Disable minimap for current window" })

-- Tab-Specific Minimap Controls
vim.keymap.set("n", "<leader>mtt", "<cmd>Neominimap TabToggle<CR>", { desc = "Toggle minimap for current tab" })
vim.keymap.set("n", "<leader>mtr", "<cmd>Neominimap TabRefresh<CR>", { desc = "Refresh minimap for current tab" })
vim.keymap.set("n", "<leader>mto", "<cmd>Neominimap TabEnable<CR>", { desc = "Enable minimap for current tab" })
vim.keymap.set("n", "<leader>mtc", "<cmd>Neominimap TabDisable<CR>", { desc = "Disable minimap for current tab" })

-- Buffer-Specific Minimap Controls
vim.keymap.set("n", "<leader>mbt", "<cmd>Neominimap BufToggle<CR>", { desc = "Toggle minimap for current buffer" })
vim.keymap.set("n", "<leader>mbr", "<cmd>Neominimap BufRefresh<CR>", { desc = "Refresh minimap for current buffer" })
vim.keymap.set("n", "<leader>mbo", "<cmd>Neominimap BufEnable<CR>", { desc = "Enable minimap for current buffer" })
vim.keymap.set("n", "<leader>mbc", "<cmd>Neominimap BufDisable<CR>", { desc = "Disable minimap for current buffer" })

-- Focus Controls
vim.keymap.set("n", "<leader>mf", "<cmd>Neominimap Focus<CR>", { desc = "Focus on minimap" })
vim.keymap.set("n", "<leader>mu", "<cmd>Neominimap Unfocus<CR>", { desc = "Unfocus minimap" })
vim.keymap.set("n", "<leader>ms", "<cmd>Neominimap ToggleFocus<CR>", { desc = "Switch focus on minimap" })
