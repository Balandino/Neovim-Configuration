-------------------------------------------------------------------------------------------------------------------------------
-- Keymappings
-------------------------------------------------------------------------------------------------------------------------------

vim.api.nvim_set_keymap("n", "<M-m>", "<Esc>", { noremap = true })

vim.api.nvim_set_keymap("i", "<M-j>", "<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "<M-k>", "<Right>", { noremap = true })
vim.api.nvim_set_keymap("i", "<M-d>", "<Up>", { noremap = true })
vim.api.nvim_set_keymap("i", "<M-f>", "<Down>", { noremap = true })

vim.api.nvim_set_keymap("n", "<M-j>", "<C-w><Left>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-k>", "<C-w><Right>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-d>", "<C-w><Up>", { noremap = true })
vim.api.nvim_set_keymap("n", "<M-f>", "<C-w><Down>", { noremap = true })

vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true })

-- BufferLine
vim.api.nvim_set_keymap("n", "<C-j>", ":BufferLineCyclePrev<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", ":BufferLineCycleNext<CR>", { noremap = true })

-- Custom code function
vim.api.nvim_set_keymap("n", "cf", "<cmd>lua FlipBoolean()<CR>", { noremap = true })

-- Code actions preview
vim.api.nvim_set_keymap("n", "<leader>a", ':lua require("actions-preview").code_actions()<CR>', { noremap = true })

-- Telescope
vim.api.nvim_set_keymap("n", "<leader>ff", ':lua require("telescope.builtin").find_files()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", ':lua require("telescope.builtin").buffers()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fd", ':lua require("telescope.builtin").diagnostics()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fv", ':lua require("telescope.builtin").vim_options()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>flg", ':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fll", ':lua require("telescope.builtin").lsp_document_symbols()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fs", ':lua require("telescope.builtin").grep_string({grep_open_files=true, only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ':lua require("telescope.builtin").live_grep({grep_open_files=true, only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fes", ':lua require("telescope.builtin").grep_string({only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>feg", ':lua require("telescope.builtin").live_grep({only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fh", ':lua require("telescope.builtin").help_tags()<CR>', { noremap = true })

vim.api.nvim_set_keymap("n", '<leader>q"', 'ciw""<Esc>P', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>q'", "ciw''<Esc>P", { noremap = true })

-- Symbols Plugin
vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>lua require'symbols-outline'.toggle_outline()<CR>", { noremap = true })

-- File tree Plugin
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua require('nvim-tree.api').tree.toggle({focus = true})<CR>", { noremap = true })

-- Trouble Plugin
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua require('trouble').toggle()<CR>", { noremap = true })

-- Neotest
vim.api.nvim_set_keymap("n", "<leader>us", ':lua require("neotest").summary.toggle()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ur", ':lua require("neotest").run.run()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>uf", ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { noremap = true })

-- Lazy
vim.api.nvim_set_keymap("n", "<leader>l", ":Lazy<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>lp", ":Lazy profile<CR>", { noremap = true })

-- Run Python
vim.api.nvim_set_keymap("n", "<F9>", ":!python %<CR>", { noremap = true })

-- Debugging
vim.api.nvim_set_keymap("n", "<F5>", ':lua require("dapui").toggle()<CR>', { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader><F5>", ':lua require("jdtls.dap").setup_dap_main_class_configs()<CR>:lua require("dapui").toggle()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<F6>", ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<F7>", ':lua require("dap").continue()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<F8>", ':lua require("dap").step_into()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><F8>", ':lua require("dap").step_over()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ds", ':lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dv", ':lua require("dap.ui.widgets").hover()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>df", ':lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>du", ':lua require("dap").up()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dd", ':lua require("dap").down()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dsi", ':lua require("dap").step_into()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dso", ':lua require("dap").step_over()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dst", ':lua require("dap").step_out()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>drc", ':lua require("dap").run_to_cursor()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dcb", ':lua require("dap").clear_breakpoints()<CR>', { noremap = true })

-- Formatting manually
vim.api.nvim_set_keymap("n", "<leader>x", ':lua require("format-on-save").format()<CR>:lua require("format-on-save").restore_cursors()<CR><C-l>', { noremap = true })

-- Copy Paste
vim.api.nvim_set_keymap("n", "<F2>", "<cmd>%y+<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F12>", 'gg0"rdGgg0"*p"<CR>', { noremap = true })

-- Lsp
vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>j", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>k", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true }) -- Now using preview plugin

-- Refactor
vim.api.nvim_set_keymap("x", "<leader>rf", ":Refactor extract<CR>", { noremap = true })
vim.api.nvim_set_keymap("x", "<leader>re", ":Refactor extract_var<CR>", { noremap = true })
vim.api.nvim_set_keymap("x", "<leader>ri", ":Refactor inline_var<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ri", ":Refactor inline_var<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rp", ':lua require("refactoring").debug.printf({ below = true })<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rv", ':lua require("refactoring").debug.print_var({})<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rc", ':lua require("refactoring").debug.cleanup({})<CR>', { noremap = true })
