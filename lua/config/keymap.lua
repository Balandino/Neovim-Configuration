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

-- Insert‑mode cursor movement
vim.keymap.set("i", "<M-j>", "<Left>")
vim.keymap.set("i", "<M-k>", "<Right>")
vim.keymap.set("i", "<M-d>", "<Up>")
vim.keymap.set("i", "<M-f>", "<Down>")

-- Normal‑mode window navigation
vim.keymap.set("n", "<M-j>", "<C-w><Left>")
vim.keymap.set("n", "<M-k>", "<C-w><Right>")
vim.keymap.set("n", "<M-d>", "<C-w><Up>")
vim.keymap.set("n", "<M-f>", "<C-w><Down>")

-- Alternative quit
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>")

-- Copy entire file to system clipboard
vim.keymap.set("n", "<F2>", "<cmd>%y+<CR>")

-- Replace entire file with register r, then paste into system clipboard
vim.keymap.set("n", "<F12>", 'gg0"rdGgg0"*p"<CR>')

-------------------------------------------------------------------------------------------------------------------------------
-- Tab Control
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<C-j>", "<cmd>tabnext<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>tabprevious<CR>")

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
vim.keymap.set({ "n", "v" }, "F", "<cmd>HopLineStartMW<CR>")
vim.keymap.set({ "n", "v" }, ";", "<cmd>HopLineStartMW<CR>")
vim.keymap.set({ "n", "v" }, "g;", "<cmd>HopLineMW<CR>")
vim.keymap.set({ "n", "v" }, "<leader>;", "<cmd>HopWordMW<CR>")

-------------------------------------------------------------------------------------------------------------------------------
-- Snipe
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "gb", require("snipe").open_buffer_menu)

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
local telescope = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", telescope.find_files)
vim.keymap.set("n", "<leader>fb", telescope.buffers)
vim.keymap.set("n", "<leader>fd", telescope.diagnostics)
vim.keymap.set("n", "<leader>fv", telescope.vim_options)
vim.keymap.set("n", "<leader>flg", telescope.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>fll", telescope.lsp_document_symbols)

-- Find functions only
vim.keymap.set("n", "<leader>flf", function()
	telescope.lsp_document_symbols({ symbols = "function" })
end)

-- Word under cursor in open buffers
vim.keymap.set("n", "<leader>fs", function()
	telescope.grep_string({ grep_open_files = true, only_sort_text = true })
end)

-- Live grep in open buffers
vim.keymap.set("n", "<leader>fg", function()
	telescope.live_grep({ grep_open_files = true, only_sort_text = true })
end)

-- Word under cursor in whole project
vim.keymap.set("n", "<leader>fes", function()
	telescope.grep_string({ only_sort_text = true })
end)

-- Live grep in whole project
vim.keymap.set("n", "<leader>feg", function()
	telescope.live_grep({ only_sort_text = true })
end)

vim.keymap.set("n", "<leader>fh", telescope.help_tags)
vim.keymap.set("n", "<leader>fgc", telescope.git_bcommits)

-------------------------------------------------------------------------------------------------------------------------------
-- Nvim-Tree
-------------------------------------------------------------------------------------------------------------------------------
local tree = require("nvim-tree.api").tree

vim.keymap.set("n", "<leader>e", function()
	tree.toggle({ focus = true })
end)

-------------------------------------------------------------------------------------------------------------------------------
-- Trouble
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>t", "<cmd>Trouble diagnostics toggle<CR>")

-------------------------------------------------------------------------------------------------------------------------------
-- Neotest
-------------------------------------------------------------------------------------------------------------------------------
local neotest = require("neotest")

-- Toggle summary
vim.keymap.set("n", "<leader>us", neotest.summary.toggle)

-- Run nearest test
vim.keymap.set("n", "<leader>ur", neotest.run.run)

-- Toggle output panel
vim.keymap.set("n", "<leader>uo", neotest.output_panel.toggle)

-- Run tests in current file
vim.keymap.set("n", "<leader>uf", function()
	neotest.run.run(vim.fn.expand("%"))
end)

-------------------------------------------------------------------------------------------------------------------------------
-- Lazy
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>")
vim.keymap.set("n", "<leader>lp", "<cmd>Lazy profile<CR>")

-------------------------------------------------------------------------------------------------------------------------------
-- Debugging
-------------------------------------------------------------------------------------------------------------------------------
local dap = require("dap")
local dapui = require("dapui")
local widgets = require("dap.ui.widgets")

-- Toggle UI
vim.keymap.set("n", "<leader><F5>", dapui.toggle)

-- Core stepping / running
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F6>", dap.toggle_breakpoint)
vim.keymap.set("n", "<F7>", dap.step_into)
vim.keymap.set("n", "<F8>", dap.step_into)
vim.keymap.set("n", "<leader><F8>", dap.step_over)

-- Widgets
vim.keymap.set("n", "<leader>ds", function()
	widgets.centered_float(widgets.scopes)
end)

vim.keymap.set("n", "<leader>dv", widgets.hover)

vim.keymap.set("n", "<leader>df", function()
	widgets.centered_float(widgets.frames)
end)

-- Stack navigation
vim.keymap.set("n", "<leader>du", dap.up)
vim.keymap.set("n", "<leader>dd", dap.down)

-- Stepping
vim.keymap.set("n", "<leader>dsi", dap.step_into)
vim.keymap.set("n", "<leader>dso", dap.step_over)
vim.keymap.set("n", "<leader>dst", dap.step_out)

-- Run to cursor
vim.keymap.set("n", "<leader>drc", dap.run_to_cursor)

-- Clear breakpoints
vim.keymap.set("n", "<leader>dcb", dap.clear_breakpoints)

-------------------------------------------------------------------------------------------------------------------------------
-- LSP
-------------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "k", vim.lsp.buf.hover)
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
