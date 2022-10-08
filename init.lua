local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
   Packer_bootstrap = vim.fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
   })
end

local status__ok, packer = pcall(require, 'packer')
if not status__ok then
   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':echo "Could not detect packer"<CR>', true, false, true), 'n',
      true)
   return
end

packer.startup({
   function(use)
      -- use({ 'ms-jpq/coq_nvim' }) -- Lsp Completion
      use({ 'ms-jpq/coq_nvim', commit = '84ec5faf2aaf49819e626f64dd94f4e71cf575bc' }) -- Lsp Completion
      use('folke/trouble.nvim') -- Panel to display error messages
      use('justinmk/vim-sneak') -- Sneak motion
      use('wellle/targets.vim') -- Adds extra text objects
      use('nvim-lua/popup.nvim') -- Part of Telescope
      use('p00f/nvim-ts-rainbow') -- Colour indented braces
      use('rcarriga/nvim-dap-ui') -- Debugging UI
      use('anuvyklack/hydra.nvim') -- Hydra
      use('windwp/nvim-autopairs') -- Automatically add closing brackets
      use('mfussenegger/nvim-dap') -- Debugging Adapter Protocol
      use('nvim-lua/plenary.nvim') -- Part of Telescope and null-ls
      use('neovim/nvim-lspconfig') -- Language Server Protocol
      use('karb94/neoscroll.nvim') -- Smooth scrolling on some commands
      use('kg8m/vim-simple-align') -- Line up blocks
      use('wbthomason/packer.nvim') -- Allow packer to manage itself
      use('windwp/nvim-ts-autotag') -- Autocomplete tags
      use('mfussenegger/nvim-jdtls') -- Java LSP
      use('williamboman/mason.nvim') -- Lsp Installer
      use('ray-x/lsp_signature.nvim') -- Show signature as a method is being typed
      use('terrortylor/nvim-comment') -- Comment lines
      use('sainnhe/gruvbox-material') -- Gruvbox port
      use('lewis6991/impatient.nvim') -- Spead up startup (via caching?)
      use('xiyaowong/nvim-transparent') -- Make all transparent
      use('mfussenegger/nvim-dap-python') -- Python debugging configurations
      use('simrat39/symbols-outline.nvim') -- Symbols sidebar
      use('jose-elias-alvarez/null-ls.nvim') -- null-ls server, used for formatting
      use('williamboman/mason-lspconfig.nvim') --  Used as part of mason.nvim
      use({ 'ms-jpq/coq.artifacts', branch = 'artifacts' }) -- Part of coq_nvim
      use({ 'ms-jpq/coq.thirdparty', branch = '3p' }) -- Part of coq_nvim
      use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }) -- Treesitter
      use({ 'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' } }) -- Lua startify
      use({ 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }) -- Status line
      use({ 'akinsho/toggleterm.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }) -- More convenient terminal
      use({ 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }) -- Nicer tabs
      use({ 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }) -- Filetree
      use({ 'nvim-telescope/telescope.nvim',
         requires = { 'kyazdani42/nvim-web-devicons', 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' } }) -- Telescope
      use({ 'nvim-neotest/neotest',
         requires = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter', 'antoinemadec/FixCursorHold.nvim',
            'nvim-neotest/neotest-python' } })
      use({ 'nvim-telescope/telescope-fzf-native.nvim',
         run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })

      if Packer_bootstrap then
         packer.sync()
      end
   end,
   config = {
      display = {
         open_fn = function()
            return require('packer.util').float({ border = 'single' })
         end,
      },
      profile = {
         enable = true,
         threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
      },
   },
})

-- Import plugin configurations
require('plugin.impatient') -- First
require('plugin.coq') -- Must be done before lsp configurations due to global variable
require('plugin.alpha')
require('plugin.sneak')
require('plugin.mason')
require('plugin.hydra')
require('plugin.dap-ui')
require('plugin.trouble')
require('plugin.null-ls')
require('plugin.lualine')
require('plugin.neotest')
require('plugin.neoscroll')
require('plugin.nvim-tree')
require('plugin.telescope')
require('plugin.bufferline')
require('plugin.toggleterm')
require('plugin.treesitter')
require('plugin.dap-python')
require('plugin.web-devicons')
require('plugin.nvim-comment')
require('plugin.lsp-signature')
require('plugin.symbols-outline')
require('plugin.mason-lspconfig')

-- Import LSP configurations
require('lsp.lua')
require('lsp.css')
require('lsp.html')
require('lsp.c_c++')
require('lsp.pyright')
require('lsp.javascript')

-- Linux specific imports
if vim.fn.has('unix') == 1 then
   require('plugins.transpancy') -- Transparency setup on Linux, not Windows
   require('lsp.java') -- Issues getting this working on Windows with 3rd Party Libraries
else
   require('lsp.c_sharp')
end

-- Custom lua functions written by me
require('custom.utilities') -- Will need to be called before other custom files
require('custom.flip_boolean')
require('custom.cpp')

-- How to create a global locked that only runs once
-- regardless of re-sourcing init.lua
-- if vim.g.setup_lsp == nil then
-- 	vim.g.setup_lsp = true
-- end

-------------------------------------------------------------------------------------------------------------------------------
-- Keymappings
-------------------------------------------------------------------------------------------------------------------------------

-- General
vim.api.nvim_set_keymap('n', 'd', 'k', { noremap = true })
vim.api.nvim_set_keymap('n', 'f', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'j', 'h', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'l', { noremap = true })
vim.api.nvim_set_keymap('n', 'h', 'd', { noremap = true })
vim.api.nvim_set_keymap('n', 'l', 'f', { noremap = true })
vim.api.nvim_set_keymap('n', 'L', 'F', { noremap = true })
vim.api.nvim_set_keymap('n', 'F', 'L', { noremap = true })
vim.api.nvim_set_keymap('n', 'hh', 'dd', { noremap = true })

vim.api.nvim_set_keymap('n', '<M-m>', '<Esc>', { noremap = true })

vim.api.nvim_set_keymap('i', '<M-j>', '<Left>', { noremap = true })
vim.api.nvim_set_keymap('i', '<M-k>', '<Right>', { noremap = true })
vim.api.nvim_set_keymap('i', '<M-d>', '<Up>', { noremap = true })
vim.api.nvim_set_keymap('i', '<M-f>', '<Down>', { noremap = true })

vim.api.nvim_set_keymap('n', '<M-j>', '<C-w><Left>', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-k>', '<C-w><Right>', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-d>', '<C-w><Up>', { noremap = true })
vim.api.nvim_set_keymap('n', '<M-f>', '<C-w><Down>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap = true })

-- Packer
vim.api.nvim_set_keymap('n', '<leader>ps', ':PackerSync<CR>', { noremap = true })

-- BufferLine
vim.api.nvim_set_keymap('n', '<C-j>', ':BufferLineCyclePrev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':BufferLineCycleNext<CR>', { noremap = true })

-- Custom function within coq.lua to select snippet highlighted sections
vim.api.nvim_set_keymap('i', '<M-c>', '<cmd>lua SelectSnippetParameterFromInsert()<CR>', { noremap = true })

-- Custom code function
vim.api.nvim_set_keymap('n', 'cf', '<cmd>lua FlipBoolean()<CR>', { noremap = true })

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fd', ':Telescope diagnostics<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fv', ':Telescope vim_options<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs',
   ':lua require("telescope.builtin").grep_string({grep_open_files=true, only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg',
   ':lua require("telescope.builtin").live_grep({grep_open_files=true, only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fes', ':lua require("telescope.builtin").grep_string({only_sort_text=true})<CR>',
   { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>feg', ':lua require("telescope.builtin").live_grep({only_sort_text=true})<CR>',
   { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>flg', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fll', ':lua require("telescope.builtin").lsp_document_symbols()<CR>',
   { noremap = true })

-- Symbols Plugin
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>SymbolsOutline<CR>', { noremap = true })

-- Trouble Plugin
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>TroubleToggle<CR>', { noremap = true })

-- Debugging
vim.api.nvim_set_keymap('n', '<F5>', ':lua require("dapui").toggle()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F6>', ':lua require("dap").toggle_breakpoint()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F7>', ':lua require("dap").continue()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F8>', ':lua require("dap").step_into()<CR>', { noremap = true })

-- Lsp
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'ga', '<cmd>Telescope lsp_code_actions<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true })

-- coq.nvim
-- Forces lsp completion to show when typing a dot.
vim.api.nvim_set_keymap('i', '.',
   '<cmd>lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(".<C-x><C-u><C-e>", true, false, true), "n", true)<CR>'
   , { noremap = true })

-- -------------------------------------------------------------------------------------------------------------------------------
-- Commands
-- -------------------------------------------------------------------------------------------------------------------------------
vim.cmd('command! Compile lua CompileCode()')
vim.cmd('command! Run lua RunCode()')
vim.cmd('command! CompileAndRun lua CompileAndRunCode()')
vim.cmd('command! Transparent highlight Normal guibg=none') -- Command to make the background transparent
vim.cmd('command! FT NvimTreeToggle')

-- -------------------------------------------------------------------------------------------------------------------------------
-- Initialisation Options
-- -------------------------------------------------------------------------------------------------------------------------------
vim.opt.wildmenu = true
vim.opt.wildmode = 'full'
vim.opt.hlsearch = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true

vim.opt.textwidth = 0
vim.opt.wrap = true
vim.opt.fileformat = 'unix' -- Prevents ^M appearing at end of lines on formatting (^M = \r sign on Windows?, use %s/\r//g to remove manually)

vim.opt.bg = 'dark'
vim.opt.hidden = true

vim.opt.splitright = true

vim.cmd("let &term = 'xterm-256color'")
vim.opt.termguicolors = true

vim.g.gruvbox_material_foreground = 'medium'
vim.cmd('colorscheme gruvbox-material')

vim.opt.foldmethod = 'expr'
-- vim.opt.foldnestmax = 1
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.cmd('set nofoldenable')

-- Places yanks in system clipboard for pasting into other programs
-- Should still work with P in nvim
vim.opt.clipboard = 'unnamedplus'

-- vim.cmd('highlight Normal guibg=none') -- Makes the background transparent

-- PRevent code folding upon file open
vim.api.nvim_create_augroup('folding', { clear = true })

vim.api.nvim_create_autocmd('BufReadPost', {
   group = 'folding',
   pattern = '*',
   callback = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('zR', true, false, true), 'n', true)
   end,
})

vim.api.nvim_create_autocmd('FileReadPost', {
   group = 'folding',
   pattern = '*',
   callback = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('zR', true, false, true), 'n', true)
   end,
})

vim.api.nvim_create_augroup('formatting', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
   group = 'formatting',
   pattern = '*',
   callback = function()
      vim.lsp.buf.format()
   end,
})

-- -------------------------------------------------------------------------------------------------------------------------------
-- Prevents highlighting showing when sourcing $MYVIMRC
-- -------------------------------------------------------------------------------------------------------------------------------
vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':noh<CR>:echo<CR>', true, false, true), 'n', true)
