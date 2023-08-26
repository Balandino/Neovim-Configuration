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

vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>q<CR>", { noremap = true })

-- BufferLine
vim.api.nvim_set_keymap("n", "<C-j>", "<cmd>BufferLineCyclePrev<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>BufferLineCycleNext<CR>", { noremap = true })

-- Custom code function
vim.api.nvim_set_keymap("n", "cf", "<cmd>lua FlipBoolean()<CR>", { noremap = true })

-- Custom code function
vim.api.nvim_set_keymap("n", "<leader>nf", "<cmd>Neogen func<CR>", { noremap = true })

-- Code actions preview
vim.api.nvim_set_keymap("n", "<leader>a", '<cmd>lua require("actions-preview").code_actions()<CR>', { noremap = true })

-- Telescope
vim.api.nvim_set_keymap("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fd", '<cmd>lua require("telescope.builtin").diagnostics()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fv", '<cmd>lua require("telescope.builtin").vim_options()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>flg", '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fll", '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fs", '<cmd>lua require("telescope.builtin").grep_string({grep_open_files=true, only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fg", '<cmd>lua require("telescope.builtin").live_grep({grep_open_files=true, only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fes", '<cmd>lua require("telescope.builtin").grep_string({only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>feg", '<cmd>lua require("telescope.builtin").live_grep({only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<CR>', { noremap = true })

vim.api.nvim_set_keymap("n", '<leader>q"', 'ciw""<Esc>P', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>q'", "ciw''<Esc>P", { noremap = true })

-- Symbols Plugin
vim.api.nvim_set_keymap("n", "<leader>o", "<cmd>lua require'symbols-outline'.toggle_outline()<CR>", { noremap = true })

-- File tree Plugin
vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>lua require('nvim-tree.api').tree.toggle({focus = true})<CR>", { noremap = true })

-- Trouble Plugin
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>lua require('trouble').toggle()<CR>", { noremap = true })

-- Neotest
vim.api.nvim_set_keymap("n", "<leader>us", '<cmd>lua require("neotest").summary.toggle()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ur", '<cmd>lua require("neotest").run.run()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>uf", '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { noremap = true })

-- Lazy
vim.api.nvim_set_keymap("n", "<leader>l", "<cmd>Lazy<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>lp", "<cmd>Lazy profile<CR>", { noremap = true })

-- Run Python
vim.api.nvim_set_keymap("n", "<F9>", "<cmd>!python %<CR>", { noremap = true })

-- Debugging
-- vim.api.nvim_set_keymap("n", "<leader><F5>", '<cmd>lua require("jdtls.dap").setup_dap_main_class_configs()<CR><cmd>lua require("dapui").toggle()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><F5>", '<cmd>lua require("dapui").toggle()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<F5>", '<cmd>lua require("dap").continue()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<F6>", '<cmd>lua require("dap").toggle_breakpoint()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<F7>", '<cmd>lua require("dap").step_into()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<F8>", '<cmd>lua require("dap").step_into()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader><F8>", '<cmd>lua require("dap").step_over()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ds", '<cmd>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dv", '<cmd>lua require("dap.ui.widgets").hover()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>df", '<cmd>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames)<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>du", '<cmd>lua require("dap").up()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dd", '<cmd>lua require("dap").down()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dsi", '<cmd>lua require("dap").step_into()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dso", '<cmd>lua require("dap").step_over()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dst", '<cmd>lua require("dap").step_out()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>drc", '<cmd>lua require("dap").run_to_cursor()<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>dcb", '<cmd>lua require("dap").clear_breakpoints()<CR>', { noremap = true })

-- Formatting manually
vim.api.nvim_set_keymap("n", "<leader>x", '<cmd>lua require("format-on-save").format()<CR><cmd>lua require("format-on-save").restore_cursors()<CR><C-l>', { noremap = true })

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
vim.api.nvim_set_keymap("x", "<leader>rf", "<cmd>Refactor extract<CR>", { noremap = true })
vim.api.nvim_set_keymap("x", "<leader>re", "<cmd>Refactor extract_var<CR>", { noremap = true })
vim.api.nvim_set_keymap("x", "<leader>ri", "<cmd>Refactor inline_var<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ri", "<cmd>Refactor inline_var<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rp", '<cmd>lua require("refactoring").debug.printf({ below = true })<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rv", '<cmd>lua require("refactoring").debug.print_var({})<CR>', { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>rc", '<cmd>lua require("refactoring").debug.cleanup({})<CR>', { noremap = true })
