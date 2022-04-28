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
		use('wbthomason/packer.nvim') -- Allow packer to manage itself
		use('windwp/nvim-ts-autotag') -- Autocomplete tags
		use('mfussenegger/nvim-jdtls') -- Java LSP
		use('feline-nvim/feline.nvim') -- Status Line
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

-------------------------------------------------------------------------------------------------------------------------------
-- Alpha, for the startify like screen
-------------------------------------------------------------------------------------------------------------------------------
require('alpha').setup(require('alpha.themes.startify').config)

-------------------------------------------------------------------------------------------------------------------------------
-- Help make plugins like alpha transparent
-------------------------------------------------------------------------------------------------------------------------------
-- Prefer transparency on Linux than Windows
if vim.fn.has('unix') == 1 then
	require('transparent').setup({
		enable = true, -- boolean: enable transparent
		extra_groups = { -- table/string: additional groups that should be clear
			-- In particular, when you set it to 'all', that means all avaliable groups
			'BufferLineTabClose',
			'BufferlineBufferSelected',
			'BufferLineFill',
			'BufferLineBackground',
			'BufferLineSeparator',
			'BufferLineIndicatorSelected',
			'all',
		},
		exclude = {}, -- table: groups you don't want to clear
	})
end
-------------------------------------------------------------------------------------------------------------------------------
-- Sneak
-------------------------------------------------------------------------------------------------------------------------------
vim.g['sneak#label'] = 1

-------------------------------------------------------------------------------------------------------------------------------
-- Bufferline
-------------------------------------------------------------------------------------------------------------------------------
require('bufferline').setup({
	options = {
		mode = 'tabs', -- set to "tabs" to only show tabpages instead
		-- numbers = function(opts)
		-- 	return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
		-- end,
		close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
		right_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
		left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		-- This plugin is designed with this icon in mind,
		-- and so changing this is NOT recommended, this is intended
		-- as an escape hatch for people who cannot bear it for whatever reason
		indicator_icon = '▎',
		buffer_close_icon = '',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',
		--- name_formatter can be used to change the buffer's label in the bufferline.
		--- Please note some names can/will break the
		--- bufferline so use this at your discretion knowing that it has
		--- some limitations that will *NOT* be fixed.
		name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
			-- remove extension from markdown files for example
			if buf.name:match('%.md') then
				return vim.fn.fnamemodify(buf.name, ':t:r')
			end
		end,
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		diagnostics = false,
		diagnostics_update_in_insert = false,
		diagnostics_indicator = function(count)
			return '(' .. count .. ')'
		end,
		-- This will be called a lot so don't do any heavy processing here
		custom_filter = function(buf_number, buf_numbers)
			-- filter out filetypes you don't want to see
			if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
				return true
			end
			-- filter out by buffer name
			if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
				return true
			end
			-- filter out based on arbitrary rules
			-- e.g. filter out vim wiki buffer from tabline in your work repo
			if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
				return true
			end
			-- filter out by it's index number in list (don't show first buffer)
			if buf_numbers[1] ~= buf_number then
				return true
			end
		end,
		offsets = { { filetype = 'NvimTree', text = 'File Explorer' } },
		show_buffer_icons = true,
		show_buffer_close_icons = false,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = 'thick',
		enforce_regular_tabs = false,
		always_show_bufferline = true,
		sort_by = 'id',
	},
})

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

local syluaConfig
if vim.fn.has('win64') == 1 then
	syluaConfig = 'C:/Lua_Formatter/stylua.toml'
else
	syluaConfig = '/home/mkg/coding/lua_formatter/stylua.toml'
end

require('null-ls').setup({
	debug = false,
	sources = {
		require('null-ls').builtins.formatting.clang_format.with({
			disabled_filetypes = { 'java' },
			filetypes = { 'c', 'cpp', 'cs' },
		}),
		require('null-ls').builtins.formatting.stylua.with({
			extra_args = { '--config-path', syluaConfig },
		}),
		require('null-ls').builtins.formatting.prettierd.with({
			filetypes = { 'css' },
		}),
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
		end
	end,
})

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
-- Symbols-outline
-------------------------------------------------------------------------------------------------------------------------------
vim.g.symbols_outline = {
	highlight_hovered_item = true,
	show_guides = true,
	auto_preview = true,
	position = 'right',
	relative_width = true,
	width = 25,
	auto_close = false,
	show_numbers = false,
	show_relative_numbrs = false,
	show_symbol_details = true,
	preview_bg_highlight = 'Pmenu',
	keymaps = { -- These keymaps can be a string or a table for multiple keys
		close = { '<Esc>', 'q' },
		goto_location = '<Cr>',
		focus_location = 'o',
		hover_symbol = '<C-space>',
		toggle_preview = 'K',
		rename_symbol = 'r',
		code_actions = 'a',
	},
	lsp_blacklist = {},
	symbol_blacklist = {},
	symbols = {
		File = { icon = '', hl = 'TSURI' },
		Module = { icon = '', hl = 'TSNamespace' },
		Namespace = { icon = '', hl = 'TSNamespace' },
		Package = { icon = '', hl = 'TSNamespace' },
		Class = { icon = '𝓒', hl = 'TSType' },
		Method = { icon = 'ƒ', hl = 'TSMethod' },
		Property = { icon = '', hl = 'TSMethod' },
		Field = { icon = '', hl = 'TSField' },
		Constructor = { icon = '', hl = 'TSConstructor' },
		Enum = { icon = 'ℰ', hl = 'TSType' },
		Interface = { icon = 'ﰮ', hl = 'TSType' },
		Function = { icon = '', hl = 'TSFunction' },
		Variable = { icon = '', hl = 'TSConstant' },
		Constant = { icon = '', hl = 'TSConstant' },
		String = { icon = '𝓐', hl = 'TSString' },
		Number = { icon = '#', hl = 'TSNumber' },
		Boolean = { icon = '⊨', hl = 'TSBoolean' },
		Array = { icon = '', hl = 'TSConstant' },
		Object = { icon = '⦿', hl = 'TSType' },
		Key = { icon = '🔐', hl = 'TSType' },
		Null = { icon = 'NULL', hl = 'TSType' },
		EnumMember = { icon = '', hl = 'TSField' },
		Struct = { icon = '𝓢', hl = 'TSType' },
		Event = { icon = '🗲', hl = 'TSType' },
		Operator = { icon = '+', hl = 'TSOperator' },
		TypeParameter = { icon = '𝙏', hl = 'TSParameter' },
	},
}

vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>SymbolsOutline<CR>', { noremap = true })

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
		jump = { '<CR>', '<tab>' }, -- jump to the diagnostic or open / close folds
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

vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>TroubleToggle<CR>', { noremap = true })

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
	-- ignore_bufer_on_setup = false,
	ignore_ft_on_setup = {},
	-- auto_close = false,
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
				{ key = '<C-z>', action = 'vsplit' },
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
-- COQ and LSP Config
-------------------------------------------------------------------------------------------------------------------------------
vim.g.coq_settings = {
	auto_start = 'shut-up', -- Must be declared before 'require "coq"'
	keymap = { recommended = false }, -- Part of Autopairs integration below
	['display.preview.border'] = 'double',
	['display.ghost_text.context'] = { '', '' },
}

-- Autopairs integration with coq_nvim - https://github.com/ms-jpq/coq_nvim/issues/91
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')

npairs.setup({ map_bs = false })

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

-- skip it, if you use another global object
_G.MUtils = {}

MUtils.CR = function()
	if vim.fn.pumvisible() ~= 0 then
		if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
			return npairs.esc('<c-y>')
		else
			return npairs.esc('<c-e>') .. npairs.autopairs_cr()
		end
	else
		return npairs.autopairs_cr()
	end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
	if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
		return npairs.esc('<c-e>') .. npairs.autopairs_bs()
	else
		return npairs.autopairs_bs()
	end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
-- Autopairs integration end

local lsp = require('lspconfig')
local coq = require('coq')

-------------------------------------------------------------------------------------------------------------------------------
-- Configuration for LSP servers.  They must be located within the global block to prevent them being re-added every time
-- init.lua is sourced.
-------------------------------------------------------------------------------------------------------------------------------
if vim.g.setup_lsp == nil then
	-------------------------------------------------------------------------------------------------------------------------------
	-- LSP Configuration for JavaScript
	-------------------------------------------------------------------------------------------------------------------------------
	lsp.tsserver.setup(coq.lsp_ensure_capabilities({
		cmd = {
			'C:/Users/Michael/AppData/Local/nvim-data/lsp_servers/tsserver/node_modules/.bin/typescript-language-server.cmd',
			'--stdio',
		},
		-- on_attach = function(client)
		-- 	client.resolved_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
		-- 	client.resolved_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
		-- end,
	}))

	-- Autoformat using tsserver instead of clang via null-ls
	vim.cmd('autocmd FileType javascript autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')

	-------------------------------------------------------------------------------------------------------------------------------
	-- LSP Configuration for HTML
	-------------------------------------------------------------------------------------------------------------------------------
	lsp.html.setup(coq.lsp_ensure_capabilities({
		cmd = {
			'C:/Users/Michael/AppData/Local/nvim-data/lsp_servers/html/node_modules/.bin/vscode-html-language-server.cmd',
			'--stdio',
		},
	}))

	-- Autoformat using tsserver instead of clang via null-ls
	vim.cmd('autocmd FileType html autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')

	-------------------------------------------------------------------------------------------------------------------------------
	-- LSP Configuration for CSS
	-------------------------------------------------------------------------------------------------------------------------------
	lsp.cssls.setup(coq.lsp_ensure_capabilities({
		cmd = {
			'C:/Users/Michael/AppData/Local/nvim-data/lsp_servers/cssls/node_modules/.bin/vscode-css-language-server.cmd',
			'--stdio',
		},
	}))

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
	if vim.fn.empty(vim.fn.glob(omnisharp_bin)) == 0 then
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
		sumneko_root_path = '/home/mkg/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin'
		sumneko_binary = '/home/mkg/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server'
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
			client.resolved_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
			client.resolved_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
		end,
	}))

	-- End of global block for LSPs
	vim.g.setup_lsp = true
end
-------------------------------------------------------------------------------------------------------------------------------
-- End of block for global LSPs
-------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------
-- Java Lsp
-------------------------------------------------------------------------------------------------------------------------------
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.

if vim.fn.has('unix') == 1 then
	vim.api.nvim_create_augroup('jdtls', { clear = true })

	-- Changes the default comment when using gcc from /* */ to //
	vim.api.nvim_create_autocmd('FileType', {
		group = 'jdtls',
		pattern = 'java',
		callback = function()
			InitiateJDTLS()
		end,
	})
end

function InitiateJDTLS()
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
	local workspace_dir = '/home/mkg/coding/jdtls_workspaces/' .. project_name

	local config = {

		-- The command that starts the language server
		-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
		cmd = { 'jdtls_launcher.sh', workspace_dir },

		root_dir = require('jdtls.setup').find_root({ 'gradle.build', 'build.gradle', 'pom.xml', '.git' }), -- Putting .git first causes issues?
		-- This is the default if not provided, you can remove it. Or adjust as needed.
		-- One dedicated LSP server & client will be started per unique root_dir

		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- for a list of options
		settings = {
			java = {},
		},

		-- Language server `initializationOptions`
		-- You need to extend the `bundles` with paths to jar files
		-- if you want to use additional eclipse.jdt.ls plugins.
		--
		-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
		--
		-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
		init_options = {
			bundles = {},
		},
	}
	-- This starts a new client & server,
	-- or attaches to an existing client & server depending on the `root_dir`.
	require('jdtls').start_or_attach(config)
end

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

	floating_window = false, -- show hint in a floating window, set to false for virtual text only mode

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
		enable = true, -- DISABLED DUE TO COMPATABILITY ISSUE WITH CURRENT NEOVIM VERSION, NEED TO TEST WITH FUTURE VERSIONS - https://github.com/p00f/nvim-ts-rainbow/issues/97
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	autotag = {
		enable = true,
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
			i = {
				['<C-z>'] = actions.select_vertical, -- Check mappings.lua for additional mappings.  Default of C-v reverts to paste in some terminals
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = 'smart_case', -- or "ignore_case" or "respect_case. The default case_mode is "smart_case"
		},
	},
})

require('telescope').load_extension('fzf')

-- vim.cmd('command! FF Telescope find_files')
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':lua require("telescope.builtin").live_grep({grep_open_files=true, only_sort_text=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>feg', ':lua require("telescope.builtin").live_grep({grep_open_files=true, only_sort_text=true, fixed_strings=true})<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>flg', ':Telescope current_buffer_fuzzy_find<CR>', { noremap = true })

-- Mappings for opening a new file
-- <C-x> go to file selection as a split
-- <C-z> go to file selection as a vsplit
-- <C-t> go to a file in a new tab

-------------------------------------------------------------------------------------------------------------------------------
-- Lsp Keymappings
-------------------------------------------------------------------------------------------------------------------------------
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
-- -- Initialisation
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

vim.g.gruvbox_material_palette = 'original'
vim.g.gruvbox_material_background = 'medium'
vim.cmd('colorscheme gruvbox-material')

vim.cmd('command! Transparent highlight Normal guibg=none') -- Command to make the background transparent
-- vim.cmd('highlight Normal guibg=none') -- Makes the background transparent

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

vim.api.nvim_set_keymap('n', '<C-j>', ':BufferLineCyclePrev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':BufferLineCycleNext<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>bn', ':BufferLineMoveNext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bb', ':BufferLineMovePrev<CR>', { noremap = true })

-------------------------------------------------------------------------------------------------------------------------------
-- Lua Functions/Additional Commands
-------------------------------------------------------------------------------------------------------------------------------
----------------- Workpad -----------------
-- print(vim.api.nvim_get_current_line())
-- print(string.sub(currentWord, 1, 1))
-- print(string.sub(currentWord, -1))
-- print(vim.api.nvim_win_get_cursor(0)[2]) -- cursor position along line, use [1] to get row

-- local currentLine = vim.api.nvim_get_current_line()
-- local cursorPosition = vim.api.nvim_win_get_cursor(0)[2]
-- local charUnderCursor = string.sub(currentLine, cursorPosition, 1)
-- local atLineEnd = ((cursorPosition + 1) == string.len(currentLine))
-- vim.cmd(vim.api.nvim_replace_termcodes('normal! viwo<Esc><left>', true, false, true))
-- vim.cmd(vim.api.nvim_replace_termcodes('normal! viwoo<Esc><Right>', true, false, true))

-------------------------------------------------------------------------
-- Select next section of snippet when dropped into insert mode - https://github.com/ms-jpq/coq_nvim/issues/91
-------------------------------------------------------------------------
function SelectSnippetParameterFromInsert()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc><C-h>', true, false, true), 'i', true)
end
vim.api.nvim_set_keymap('i', '<M-c>', '<cmd>lua SelectSnippetParameterFromInsert()<CR>', { noremap = true })

-------------------------------------------------------------------------
-- Flip boolean
-------------------------------------------------------------------------
function FlipBoolean()
	local currentWord = vim.call('expand', '<cword>')

	local booleans = { 'True', 'False', 'true', 'false' }
	local inverse = { 'False', 'True', 'false', 'true' }

	for value = 1, 4 do
		if currentWord == booleans[value] then
			vim.cmd('normal! diwi' .. inverse[value])
			return
		end
	end
end

vim.api.nvim_set_keymap('n', 'cf', '<cmd>lua FlipBoolean()<CR>', { noremap = true })

-------------------------------------------------------------------------
-- Surround current word in quotes
-------------------------------------------------------------------------
function SurroundSingleQuote()
	Surround("'", "'")
end

function SurroundDoubleQuote()
	Surround('"', '"')
end

function SurroundAngleBrackets()
	Surround('<', '>')
end

function SurroundBraces()
	Surround('{', '}')
end

function SurroundBrackets()
	Surround('(', ')')
end

-- Cannot currently detect if word already surrounded by symbol
function Surround(leftSymbol, rightSymbol)
	local currentWord = vim.call('expand', '<cword>')
	vim.cmd('normal! diwi' .. leftSymbol .. currentWord .. rightSymbol)
end

vim.api.nvim_set_keymap('n', 'cs{', '<cmd>lua SurroundBraces()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'cs}', '<cmd>lua SurroundBraces()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'cs(', '<cmd>lua SurroundBrackets()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'cs)', '<cmd>lua SurroundBrackets()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', "cs'", '<cmd>lua SurroundSingleQuote()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'cs"', '<cmd>lua SurroundDoubleQuote()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'cs<', '<cmd>lua SurroundAngleBrackets()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', 'cs>', '<cmd>lua SurroundAngleBrackets()<CR>', { noremap = true })

-------------------------------------------------------------------------
-- Lua & Vim commands for compiling and running code in current buffer
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
	local cppCompile = ' -std=c++20 -isystem "C:\\Coding\\3rd_Party\\C++\\fmt\\include" -L "C:\\Coding\\3rd_Party\\C++\\fmt\\build" -l:libfmt.a'

	if currentFileExtension ~= 'no_extension' then
		if currentFileExtension == 'cpp' then
			if compile == true and run == true then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':!clang++ ' .. currentFilePath .. ' -o ' .. currentfileName .. '.exe' .. cppCompile .. '<CR><CR>:!' .. currentfileName .. '.exe<CR>', true, false, true), 'n', true)
			elseif compile == true then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':!clang++ ' .. currentFilePath .. ' -o ' .. currentfileName .. '.exe' .. cppCompile .. '<CR>', true, false, true), 'n', true)
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

function GetInput()
	local confirmation = vim.fn.input('Include fmt? (y|n):')
	print('Result: ' .. confirmation)
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

vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(':noh<CR>:echo<CR>', true, false, true), 'n', true) -- Prevents highlighting showing when sourcing $MYVIMRC
