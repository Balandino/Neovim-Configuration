-- https://github.com/microsoft/terminal/issues/9381 (Windows terminal font issue)

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

require('packer').startup(function(use)
	use('wbthomason/packer.nvim') -- Allow packer to manage itself
	use('karb94/neoscroll.nvim') -- Smooth scrolling on some commands
	use('neovim/nvim-lspconfig') -- Language Server Protocol
	use('wellle/targets.vim') -- Adds extra text objects, use to go to brackets from a distance
	use('tpope/vim-surround') -- Used to alter surrounding quotes
	use('nvim-lua/popup.nvim') -- Part of Telescope
	use('nvim-lua/plenary.nvim') -- Part of Telescope and null-ls
	use('nvim-telescope/telescope.nvim') -- Telescope
	use('hoob3rt/lualine.nvim') -- Status line
	use('kyazdani42/nvim-web-devicons') -- Icons compatible with the status line, Telescope, alpha-nvim, nvim-tree, trouble and bufferline
	use('ms-jpq/coq_nvim') -- Lsp Completion
	use('williamboman/nvim-lsp-installer') -- Lsp installer
	use('ray-x/lsp_signature.nvim') -- Show signature as a method is being typed
	use('ryanoasis/vim-devicons') -- Icons for ChadTree
	use('tiagofumo/vim-nerdtree-syntax-highlight') -- Theme for ChadTree
	use('rktjmp/lush.nvim') -- Required for below Gruvbox theme
	use('ellisonleao/gruvbox.nvim') -- Gruvbox ported for lua and Treesitter
	use('jiangmiao/auto-pairs') -- Automatically add closing brackets
	use('jose-elias-alvarez/null-ls.nvim') -- null-ls server, used for formatting
	use('folke/trouble.nvim') -- Panel to display error messages
	use('p00f/nvim-ts-rainbow') -- Colour indented braces
	use('goolord/alpha-nvim') -- Lua startify
	use('kyazdani42/nvim-tree.lua') -- Filetree
	use('terrortylor/nvim-comment') -- Comment lines
	use('akinsho/toggleterm.nvim') -- More convenient terminal
	use('akinsho/bufferline.nvim') -- Nicer tabs
	use('justinmk/vim-sneak') -- Sneak motion
	use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }) -- Treesitter
	use({ 'ms-jpq/coq.artifacts', branch = 'artifacts' }) -- Part of coq_nvim
	if Packer_bootstrap then
		require('packer').sync()
	end
end)

-------------------------------------------------------------------------------------------------------------------------------
-- Lua function to assist plugins
-------------------------------------------------------------------------------------------------------------------------------
function CheckExists(pathway) -- Confirm if a file exists
	if vim.fn.empty(vim.fn.glob(pathway)) == 0 then
		return 'found'
	else
		return 'missing'
	end
end

-------------------------------------------------------------------------------------------------------------------------------
-- Alpha, for the startify like screen
-------------------------------------------------------------------------------------------------------------------------------
require('alpha').setup(require('alpha.themes.startify').config)

-------------------------------------------------------------------------------------------------------------------------------
-- Sneak
-------------------------------------------------------------------------------------------------------------------------------
vim.g['sneak#label'] = 1

-------------------------------------------------------------------------------------------------------------------------------
-- Bufferline
-------------------------------------------------------------------------------------------------------------------------------
require('bufferline').setup({})

-------------------------------------------------------------------------------------------------------------------------------
-- nvim-comment
-------------------------------------------------------------------------------------------------------------------------------
require('nvim_comment').setup()

vim.api.nvim_create_augroup('comment_symbol', { clear = true })

-- Changes the default comment when using gcc from /* */ to //
vim.api.nvim_create_autocmd('BufEnter', {
	group = 'comment_symbol',
	pattern = '*.cpp,*.h,*.c,*.java',
	callback = function()
		vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
	end,
})

-- Changes the default comment when using gcc from /* */ to //
vim.api.nvim_create_autocmd('BufFilePost', {
	group = 'comment_symbol',
	pattern = '*.cpp,*.h,*.c,*.java',
	callback = function()
		vim.api.nvim_buf_set_option(0, 'commentstring', '// %s')
	end,
})

-------------------------------------------------------------------------------------------------------------------------------
-- Neoscroll
-------------------------------------------------------------------------------------------------------------------------------

require('neoscroll').setup({
	-- All these keys will be mapped to their corresponding default scrolling animation
	mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
	hide_cursor = true, -- Hide cursor while scrolling
	stop_eof = true, -- Stop at <EOF> when scrolling downwards
	use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
	respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
	cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
	easing_function = nil, -- Default easing function
	pre_hook = nil, -- Function to run before the scrolling animation starts
	post_hook = nil, -- Function to run after the scrolling animation ends
})

------------------------------------------------------------------------------------------------------------------------------
-- null-ls (formatting)
-------------------------------------------------------------------------------------------------------------------------------
require('null-ls').setup({
	sources = {
		--		require("null-ls").builtins.formatting.stylua,
		require('null-ls').builtins.formatting.clang_format,
		require('null-ls').builtins.formatting.stylua.with({
			extra_args = { '--config-path', 'C:/Lua_Formatter/stylua.toml' },
		}),
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
		end
	end,
})

------------------------------------------------------------------------------------------------------------------------------
-- COQ and LSP Config
-------------------------------------------------------------------------------------------------------------------------------
vim.g.coq_settings = {
	auto_start = 'shut-up', -- Must be declared before 'require "coq"'
	['display.preview.border'] = 'single',
}

local lsp = require('lspconfig')
local coq = require('coq')

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
vim.api.nvim_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { noremap = true })

-------------------------------------------------------------------------------------------------------------------------------
-- Toggleterm
-------------------------------------------------------------------------------------------------------------------------------
require('toggleterm').setup({
	-- size can be a number or function which is passed the current terminal
	size = 25,
	open_mapping = [[<c-\>]], -- <c-#> also works???
	-- on_open = fun(t: Terminal), -- function to run when the terminal opens
	-- on_close = fun(t: Terminal), -- function to run when the terminal closes
	-- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
	-- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
	-- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
	hide_numbers = true, -- hide the number column in toggleterm buffers
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
	start_in_insert = true,
	insert_mappings = true, -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
	persist_size = true,
	direction = 'float',
	close_on_exit = true, -- close the terminal window when the process exits
	shell = vim.o.shell, -- change the default shell
	-- This field is only relevant if direction is set to 'float'
	float_opts = {
		-- The border key is *almost* the same as 'nvim_open_win'
		-- see :h nvim_open_win for details on borders however
		-- the 'curved' border is a custom border type
		-- not natively supported but implemented in this plugin.
		-- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
		border = 'curved',
		-- width = 305,
		-- height = 205,
		winblend = 3,
		highlights = {
			border = 'Normal',
			background = 'Normal',
		},
	},
})

-------------------------------------------------------------------------------------------------------------------------------
-- Trouble
-------------------------------------------------------------------------------------------------------------------------------

require('trouble').setup({
	position = 'bottom', -- position of the list can be: bottom, top, left, right
	height = 10, -- height of the trouble list when position is top or bottom
	width = 50, -- width of the list when position is left or right
	icons = true, -- use devicons for filenames
	mode = 'workspace_diagnostics', -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
	fold_open = '', -- icon used for open folds
	fold_closed = '', -- icon used for closed folds
	group = true, -- group results by file
	padding = true, -- add an extra new line on top of the list
	action_keys = { -- key mappings for actions in the trouble list
		-- map to {} to remove a mapping, for example:
		-- close = {},
		close = 'q', -- close the list
		cancel = '<esc>', -- cancel the preview and get back to your last window / buffer / cursor
		refresh = 'r', -- manually refresh
		jump = { '<cr>', '<tab>' }, -- jump to the diagnostic or open / close folds
		open_split = { '<c-x>' }, -- open buffer in new split
		open_vsplit = { '<c-v>' }, -- open buffer in new vsplit
		open_tab = { '<c-t>' }, -- open buffer in new tab
		jump_close = { 'o' }, -- jump to the diagnostic and close the list
		toggle_mode = 'm', -- toggle between "workspace" and "document" diagnostics mode
		toggle_preview = 'P', -- toggle auto_preview
		hover = 'K', -- opens a small popup with the full multiline message
		preview = 'p', -- preview the diagnostic location
		close_folds = { 'zM', 'zm' }, -- close all folds
		open_folds = { 'zR', 'zr' }, -- open all folds
		toggle_fold = { 'zA', 'za' }, -- toggle fold of current file
		previous = 'k', -- preview item
		next = 'j', -- next item
	},
	indent_lines = true, -- add an indent guide below the fold icons
	auto_open = false, -- automatically open the list when you have diagnostics
	auto_close = false, -- automatically close the list when you have no diagnostics
	auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
	auto_fold = false, -- automatically fold a file trouble list at creation
	auto_jump = { 'lsp_definitions' }, -- for the given modes, automatically jump if there is only a single result
	signs = {
		-- icons / text used for a diagnostic
		error = '',
		warning = '',
		hint = '',
		information = '',
		other = '﫠',
	},
	use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
})

-------------------------------------------------------------------------------------------------------------------------------
-- nvim-tree
-------------------------------------------------------------------------------------------------------------------------------
-- init.lua

-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require('nvim-tree').setup({
	disable_netrw = false,
	hijack_netrw = true,
	open_on_setup = false,
	ignore_bufer_on_setup = false,
	ignore_ft_on_setup = {},
	auto_close = false,
	auto_reload_on_write = true,
	open_on_tab = false,
	hijack_cursor = false,
	update_cwd = false,
	hijack_unnamed_buffer_when_opening = false,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = false,
		icons = {
			hint = '',
			info = '',
			warning = '',
			error = '',
		},
	},
	update_focused_file = {
		enable = false,
		update_cwd = false,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		height = 30,
		hide_root_folder = false,
		side = 'left',
		preserve_window_proportions = false,
		mappings = {
			custom_only = false,
			list = {
				{ key = 'd', action = '' }, -- overwrites default, freeing it for upwards movement
			},
		},
		number = true,
		relativenumber = true,
		signcolumn = 'yes',
	},
	trash = {
		cmd = 'trash',
		require_confirm = true,
	},
	actions = {
		change_dir = {
			enable = true,
			global = false,
		},
		open_file = {
			quit_on_open = false,
			resize_window = false,
			window_picker = {
				enable = true,
				chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
				exclude = {
					filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
					buftype = { 'nofile', 'terminal', 'help' },
				},
			},
		},
	},
})

vim.cmd('command! FT NvimTreeToggle')

-------------------------------------------------------------------------------------------------------------------------------
-- LSP Configuration for C/C++ - clangd
-------------------------------------------------------------------------------------------------------------------------------
lsp.clangd.setup(coq.lsp_ensure_capabilities({
	cmd = {
		'clangd',
		'--background-index',
		'--suggest-missing-includes',
	},
	filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
		client.resolved_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
	end,
}))

-------------------------------------------------------------------------------------------------------------------------------
-- LSP Configuration for C# - omnisharp
-------------------------------------------------------------------------------------------------------------------------------
local omnisharp_bin = 'C:/Users/Michael/AppData/Local/nvim-data/lsp_servers/omnisharp/omnisharp/OmniSharp.exe'
if CheckExists(omnisharp_bin) == 'found' then
	local pid = vim.fn.getpid()
	lsp.omnisharp.setup(coq.lsp_ensure_capabilities({
		cmd = {
			omnisharp_bin,
			'--languageserver',
			'--hostPID',
			tostring(pid),
		},
		on_attach = function(client)
			client.resolved_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
			client.resolved_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
		end,
	}))
end

-------------------------------------------------------------------------------------------------------------------------------
-- LSP Configuration for Lua
-------------------------------------------------------------------------------------------------------------------------------

local sumneko_root_path = ''
local sumneko_binary = ''

if vim.fn.has('win64') == 1 then
	sumneko_root_path = 'C:/Users/Michael/AppData/Local/nvim-data/lsp_servers/sumneko_lua/extension/server/bin'
	sumneko_binary = 'C:/Users/Michael/AppData/Local/nvim-data/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server.exe'
elseif vim.fn.has('unix') == 1 then
	--    sumneko_root_path = "/home/" .. USER .. "/.config/nvim/lua-language-server"
	--    sumneko_binary = "/home/" .. USER .. "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
end

lsp.sumneko_lua.setup(coq.lsp_ensure_capabilities({
	cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
		},
	},
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end,
}))

-------------------------------------------------------------------------------------------------------------------------------
-- LSP Signature
-------------------------------------------------------------------------------------------------------------------------------
local cfg = {
	debug = false, -- set to true to enable debug logging
	log_path = 'debug_log_file_path', -- debug log path
	verbose = false, -- show debug line number

	doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
	-- set to 0 if you DO NOT want any API comments be shown
	-- This setting only take effect in insert mode, it does not affect signature help in normal
	-- mode, 10 by default

	floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

	floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
	-- will set to true when fully tested, set to false will use whichever side has more space
	-- this setting will be helpful if you do not want the PUM and floating win overlap

	fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
	hint_enable = true, -- virtual hint enable
	hint_prefix = ' ', -- Symbol for parameter
	hint_scheme = 'String',
	use_lspsaga = false, -- set to true if you want to use lspsaga popup
	hi_parameter = 'LspSignatureActiveParameter', -- how your parameter will be highlight
	max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
	-- to view the hiding contents

	max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
	--   transpancy = 10,          -- set this value if you want the floating windows to be transpant (100 fully transpant), nil to disable(default) -- Duplicate line?
	handler_opts = {
		border = 'single', -- double, single, shadow, none
	},

	always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

	auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
	extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
	zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

	padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

	transpancy = nil, -- disabled by default, allow floating win transparent value 1~100
	shadow_blend = 36, -- if you using shadow as border use this set the opacity
	shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
	timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
	toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

-- recommended:
require('lsp_signature').setup(cfg)

-------------------------------------------------------------------------------------------------------------------------------
-- Setup DevIcons
-------------------------------------------------------------------------------------------------------------------------------
require('nvim-web-devicons').setup({
	default = true, -- globally enable default icons (default to false), will get overriden by 'get_icons' option
})

-------------------------------------------------------------------------------------------------------------------------------
-- Treesitter
-------------------------------------------------------------------------------------------------------------------------------
require('nvim-treesitter.configs').setup({
	highlight = {
		enable = true,
	},
	rainbow = {
		enable = false, -- DISABLED DUE TO COMPATABILITY ISSUE WITH CURRENT NEOVIM VERSION, NEED TO TEST WITH FUTURE VERSIONS - https://github.com/p00f/nvim-ts-rainbow/issues/97
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})

-------------------------------------------------------------------------------------------------------------------------------
-- Status line - lualine
-------------------------------------------------------------------------------------------------------------------------------
require('lualine').setup({
	options = {
		icons_enabled = true,
		theme = 'gruvbox',
		component_separators = { '', '' },
		section_separators = { '', '' },
		disabled_filetypes = {},
	},

	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch' },
		lualine_c = { 'filename', 'diagnostics' },
		lualine_x = { 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},

	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {},
	},

	tabline = {},
	extensions = {},
})

-------------------------------------------------------------------------------------------------------------------------------
-- Telescope
-------------------------------------------------------------------------------------------------------------------------------

local actions = require('telescope.actions')
require('telescope').setup({
	defaults = {
		mappings = {
			n = {
				['<C-z>'] = actions.select_vertical, -- Check mappings.lua for additional mappings.  Default of C-v reverts to paste in some terminals
			},
		},
	},
})

vim.cmd('command! FF Telescope find_files')

-- Mappings for opening a new file
-- <C-x> go to file selection as a split
-- <C-z> go to file selection as a vsplit
-- <C-t> go to a file in a new tab

-------------------------------------------------------------------------------------------------------------------------------
-- Initialisation
-------------------------------------------------------------------------------------------------------------------------------
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

vim.opt.termguicolors = true
vim.opt.bg = 'dark'
vim.opt.hidden = true

vim.cmd('command! Transparent highlight Normal guibg=none') -- Makes the background transparent
vim.cmd('syntax on')
vim.cmd("let &term = 'xterm-256color'")
vim.cmd('colorscheme gruvbox')

vim.api.nvim_set_keymap('n', 'd', 'k', { noremap = true })
vim.api.nvim_set_keymap('n', 'f', 'j', { noremap = true })
vim.api.nvim_set_keymap('n', 'j', 'h', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'l', { noremap = true })
vim.api.nvim_set_keymap('n', 'h', 'd', { noremap = true })
vim.api.nvim_set_keymap('n', 'l', 'f', { noremap = true })
vim.api.nvim_set_keymap('n', 'L', 'F', { noremap = true })
vim.api.nvim_set_keymap('n', 'F', 'L', { noremap = true })
vim.api.nvim_set_keymap('n', 'hh', 'dd', { noremap = true })

vim.api.nvim_set_keymap('n', '<c-j>', 'gT', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-k>', 'gt', { noremap = true })

-------------------------------------------------------------------------------------------------------------------------------
-- Lua Functions/Additional Commands
-------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Lua & Vim commands for compiling and running code in current buffer  |
-------------------------------------------------------------------------

function CompileCode()
	CompileAndOptionallyRun(true, false)
end

function RunCode()
	CompileAndOptionallyRun(false, true)
end

function CompileAndRunCode()
	CompileAndOptionallyRun(true, true)
end

function CompileAndOptionallyRun(compile, run)
	local currentFilePath = vim.fn.expand('%:p')
	local currentFileExtension = GetExtension()
	local currentfileName = GetFileNameWithoutExtension()

	if currentFileExtension ~= 'no_extension' then
		if currentFileExtension == 'cpp' then
			if compile == true and run == true then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':!clang++ -std=c++20 ' .. currentFilePath .. ' -o ' .. currentfileName .. '.exe<CR><CR>:!' .. currentfileName .. '.exe<CR>', true, false, true), 'n', true)
			elseif compile == true then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':!clang++ -std=c++20 ' .. currentFilePath .. ' -o ' .. currentfileName .. '.exe<CR>', true, false, true), 'n', true)
			elseif run == true then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':!' .. currentfileName .. '.exe<CR>', true, false, true), 'n', true)
			end
		else
			print('No compile instructions yet created for files of type ' .. currentFileExtension)
		end
	else
		print('Cannot locate extension for file, cannot compile.')
	end
end

function GetExtension()
	local filePath = vim.fn.expand('%:p')
	local fullstop = string.match(filePath, '^.*()[.]')
	local length = string.len(filePath)

	if fullstop ~= nil then
		return string.sub(filePath, fullstop + 1, length)
	else
		return 'no_extension'
	end
end

function GetFileNameWithoutExtension()
	local fileName = vim.fn.expand('%:t')
	local fullstop = string.match(fileName, '^.*()[.]')

	if fullstop ~= nil then
		return string.sub(fileName, 1, fullstop - 1)
	else
		return 'no_extension'
	end
end

vim.cmd('command! Compile lua CompileCode()')
vim.cmd('command! Run lua RunCode()')
vim.cmd('command! CompileAndRun lua CompileAndRunCode()')
