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
require('packer').startup({
	function(use)
		use('ms-jpq/coq_nvim') -- Lsp Completion
		use('folke/trouble.nvim') -- Panel to display error messages
		use('justinmk/vim-sneak') -- Sneak motion
		use('wellle/targets.vim') -- Adds extra text objects
		use('nvim-lua/popup.nvim') -- Part of Telescope
		use('p00f/nvim-ts-rainbow') -- Colour indented braces
		use('windwp/nvim-autopairs') -- Automatically add closing brackets
		use('nvim-lua/plenary.nvim') -- Part of Telescope and null-ls
		use('neovim/nvim-lspconfig') -- Language Server Protocol
		use('karb94/neoscroll.nvim') -- Smooth scrolling on some commands
		use('kg8m/vim-simple-align') -- Line up blocks
		use('wbthomason/packer.nvim') -- Allow packer to manage itself
		use('windwp/nvim-ts-autotag') -- Autocomplete tags
		use('mfussenegger/nvim-jdtls') -- Java LSP
		use('ray-x/lsp_signature.nvim') -- Show signature as a method is being typed
		use('terrortylor/nvim-comment') -- Comment lines
		use('sainnhe/gruvbox-material') -- Gruvbox port
		use('xiyaowong/nvim-transparent') -- Make all transparent
		use('simrat39/symbols-outline.nvim') -- Symbols sidebar
		use('jose-elias-alvarez/null-ls.nvim') -- null-ls server, used for formatting
		use('williamboman/nvim-lsp-installer') -- Lsp installer
		use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }) -- For telescope fuzzy finding
		use({ 'ms-jpq/coq.artifacts', branch = 'artifacts' }) -- Part of coq_nvim
		use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }) -- Treesitter
		use({ 'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' } }) -- Lua startify
		use({ 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }) -- Status line
		use({ 'akinsho/toggleterm.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }) -- More convenient terminal
		use({ 'akinsho/bufferline.nvim', requires = { 'kyazdani42/nvim-web-devicons' } }) -- Nicer tabs
		use({ 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }) -- Filetree
		use({ 'nvim-telescope/telescope.nvim', requires = { { 'kyazdani42/nvim-web-devicons' }, { 'nvim-lua/plenary.nvim' }, { 'nvim-lua/popup.nvim' } } }) -- Telescope
		if Packer_bootstrap then
			require('packer').sync()
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
require('plugin.coq')
require('plugin.alpha')
require('plugin.sneak')
require('plugin.trouble')
require('plugin.null-ls')
require('plugin.lualine')
require('plugin.neoscroll')
require('plugin.nvim-tree')
require('plugin.telescope')
require('plugin.bufferline')
require('plugin.toggleterm')
require('plugin.treesitter')
require('plugin.web-devicons')
require('plugin.nvim-comment')
require('plugin.lsp-signature')
require('plugin.symbols-outline')

-- Import LSP configurations
require('lsp.css')
require('lsp.lua')
require('lsp.html')
require('lsp.c_c++')
require('lsp.c_sharp')
require('lsp.javascript')

-- Linux specific imports
if vim.fn.has('unix') == 1 then
	require('plugins.transpancy') -- Transparency setup on Linux, not Windows
	require('lsp.java') -- Issues getting this working on Windows
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
vim.api.nvim_set_keymap('n', '<leader>fes', ':lua require("telescope.builtin").grep_string({only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>feg', ':lua require("telescope.builtin").live_grep({only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>flg', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', ':lua require("telescope.builtin").grep_string({grep_open_files=true       , only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':lua require("telescope.builtin").live_grep({grep_open_files=true         , only_sort_text=true})<CR>', { noremap = true })

-- Symbols Plugin
vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>SymbolsOutline<CR>', { noremap = true })

-- Trouble Plugin
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>TroubleToggle<CR>', { noremap = true })

-- Lsp
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'ga', '<cmd>Telescope lsp_code_actions<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>j', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true })

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

-- vim.cmd('highlight Normal guibg=none') -- Makes the background transparent

-- -------------------------------------------------------------------------------------------------------------------------------
-- Prevents highlighting showing when sourcing $MYVIMRC
-- -------------------------------------------------------------------------------------------------------------------------------
vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':noh<CR>:echo<CR>', true, false, true), 'n', true)
