-------------------------------------------------------------------------------------------------------------------------------
-- Keymappings
-------------------------------------------------------------------------------------------------------------------------------

vim.keymap.set("n", "<M-m>", "<Esc>", { noremap = true })

vim.keymap.set("i", "<M-j>", "<Left>", { noremap = true })
vim.keymap.set("i", "<M-k>", "<Right>", { noremap = true })
vim.keymap.set("i", "<M-d>", "<Up>", { noremap = true })
vim.keymap.set("i", "<M-f>", "<Down>", { noremap = true })

vim.keymap.set("n", "<M-j>", "<C-w><Left>", { noremap = true })
vim.keymap.set("n", "<M-k>", "<C-w><Right>", { noremap = true })
vim.keymap.set("n", "<M-d>", "<C-w><Up>", { noremap = true })
vim.keymap.set("n", "<M-f>", "<C-w><Down>", { noremap = true })

vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { noremap = true })

-- Hop
vim.keymap.set({ "n", "v" }, "s", "<cmd>HopChar2MW<CR>", { noremap = true })
vim.keymap.set({ "n", "v" }, "S", "<cmd>HopChar1MW<CR>", { noremap = true })
vim.keymap.set({ "n", "v" }, "f", "<cmd>HopChar1CurrentLine<CR>", { noremap = true })
vim.keymap.set({ "n", "v" }, "F", "<cmd>HopLineStartMW<CR>", { noremap = true })
vim.keymap.set({ "n", "v" }, ";", "<cmd>HopLineStartMW<CR>", { noremap = true })
vim.keymap.set({ "n", "v" }, "g;", "<cmd>HopLineMW<CR>", { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>;", "<cmd>HopWordMW<CR>", { noremap = true })

-- snipe
vim.keymap.set("n", "gb", "<cmd>lua require('snipe').open_buffer_menu()<CR>", { noremap = true })

-- Tabs
vim.keymap.set("n", "<C-j>", "<cmd>tabnext<CR>", { noremap = true })
vim.keymap.set("n", "<C-k>", "<cmd>tabprevious<CR>", { noremap = true })

-- Custom code function
vim.keymap.set("n", "cf", "<cmd>lua FlipBoolean()<CR>", { noremap = true })

-- Neogen
vim.keymap.set("n", "<leader>nf", "<cmd>Neogen func<CR>", { noremap = true })

-- Code actions preview
vim.keymap.set("n", "<leader>a", '<cmd>lua require("actions-preview").code_actions()<CR>', { noremap = true })

-- Telescope
vim.keymap.set("n", "<leader>ff", '<cmd>lua require("telescope.builtin").find_files()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>fb", '<cmd>lua require("telescope.builtin").buffers()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>fd", '<cmd>lua require("telescope.builtin").diagnostics()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>fv", '<cmd>lua require("telescope.builtin").vim_options()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>flg", '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>',
   { noremap = true })
vim.keymap.set("n", "<leader>fll", '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>flf", '<cmd>lua require("telescope.builtin").lsp_document_symbols({symbols="function"})<CR>',
   { noremap = true })
vim.keymap.set("n", "<leader>fs",
   '<cmd>lua require("telescope.builtin").grep_string({grep_open_files=true, only_sort_text=true})<CR>',
   { noremap = true })
vim.keymap.set("n", "<leader>fg",
   '<cmd>lua require("telescope.builtin").live_grep({grep_open_files=true, only_sort_text=true})<CR>', { noremap = true })
vim.keymap.set("n", "<leader>fes", '<cmd>lua require("telescope.builtin").grep_string({only_sort_text=true})<CR>',
   { noremap = true })
vim.keymap.set("n", "<leader>feg", '<cmd>lua require("telescope.builtin").live_grep({only_sort_text=true})<CR>',
   { noremap = true })
vim.keymap.set("n", "<leader>fh", '<cmd>lua require("telescope.builtin").help_tags()<CR>', { noremap = true })

vim.keymap.set("n", "<leader>fgc", '<cmd>lua require("telescope.builtin").git_bcommits()<CR>', { noremap = true })

vim.keymap.set("n", '<leader>q"', 'ciw""<Esc>P', { noremap = true })
vim.keymap.set("n", "<leader>q'", "ciw''<Esc>P", { noremap = true })

-- Symbols Plugin
vim.keymap.set("n", "<leader>o", "<cmd>lua require'symbols-outline'.toggle_outline()<CR>", { noremap = true })

-- File tree Plugin
vim.keymap.set("n", "<leader>e", "<cmd>lua require('nvim-tree.api').tree.toggle({focus = true})<CR>", { noremap = true })

-- Trouble Plugin
vim.keymap.set("n", "<leader>t", "<cmd>Trouble diagnostics toggle<CR>", { noremap = true })

-- Neotest
vim.keymap.set("n", "<leader>us", '<cmd>lua require("neotest").summary.toggle()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>ur", '<cmd>lua require("neotest").run.run()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>uo", '<cmd>lua require("neotest").output_panel.toggle()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>uf", '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', { noremap = true })

-- Lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { noremap = true })
vim.keymap.set("n", "<leader>lp", "<cmd>Lazy profile<CR>", { noremap = true })

-- Run Python
vim.keymap.set("n", "<F10>", "<cmd>!python %<CR>", { noremap = true })

-- Debugging
-- vim.keymap.set("n", "<leader><F5>", '<cmd>lua require("jdtls.dap").setup_dap_main_class_configs()<CR><cmd>lua require("dapui").toggle()<CR>', { noremap = true })
vim.keymap.set("n", "<leader><F5>", '<cmd>lua require("dapui").toggle()<CR>', { noremap = true })
vim.keymap.set("n", "<F5>", '<cmd>lua require("dap").continue()<CR>', { noremap = true })
vim.keymap.set("n", "<F6>", '<cmd>lua require("dap").toggle_breakpoint()<CR>', { noremap = true })
vim.keymap.set("n", "<F7>", '<cmd>lua require("dap").step_into()<CR>', { noremap = true })
vim.keymap.set("n", "<F8>", '<cmd>lua require("dap").step_into()<CR>', { noremap = true })
vim.keymap.set("n", "<leader><F8>", '<cmd>lua require("dap").step_over()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>ds",
   '<cmd>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes)<CR>', { noremap = true })
vim.keymap.set("n", "<leader>dv", '<cmd>lua require("dap.ui.widgets").hover()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>df",
   '<cmd>lua require("dap.ui.widgets").centered_float(require("dap.ui.widgets").frames)<CR>', { noremap = true })
vim.keymap.set("n", "<leader>du", '<cmd>lua require("dap").up()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>dd", '<cmd>lua require("dap").down()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>dsi", '<cmd>lua require("dap").step_into()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>dso", '<cmd>lua require("dap").step_over()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>dst", '<cmd>lua require("dap").step_out()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>drc", '<cmd>lua require("dap").run_to_cursor()<CR>', { noremap = true })
vim.keymap.set("n", "<leader>dcb", '<cmd>lua require("dap").clear_breakpoints()<CR>', { noremap = true })

-- Copy Paste
vim.keymap.set("n", "<F2>", "<cmd>%y+<CR>", { noremap = true })
vim.keymap.set("n", "<F12>", 'gg0"rdGgg0"*p"<CR>', { noremap = true })

-- Lsp
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true })
vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true })
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true })
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true })
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true })
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>j", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true })
vim.keymap.set("n", "<leader>k", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", { noremap = true }) -- Now using preview plugin

-- Refactor
vim.keymap.set("x", "<leader>rf", "<cmd>Refactor extract<CR>", { noremap = true })
vim.keymap.set("x", "<leader>re", "<cmd>Refactor extract_var<CR>", { noremap = true })
vim.keymap.set("x", "<leader>ri", "<cmd>Refactor inline_var<CR>", { noremap = true })
vim.keymap.set("n", "<leader>ri", "<cmd>Refactor inline_var<CR>", { noremap = true })
vim.keymap.set("n", "<leader>rp", '<cmd>lua require("refactoring").debug.printf({ below = true })<CR>',
   { noremap = true })
vim.keymap.set("n", "<leader>rv", '<cmd>lua require("refactoring").debug.print_var({})<CR>', { noremap = true })
vim.keymap.set("n", "<leader>rc", '<cmd>lua require("refactoring").debug.cleanup({})<CR>', { noremap = true })
