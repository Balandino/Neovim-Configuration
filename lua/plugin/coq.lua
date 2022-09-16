require('coq_3p')({
	{ src = 'nvimlua', short_name = 'nLUA' },
})

vim.g.coq_settings = {
	auto_start = 'shut-up', -- Must be declared before 'require "coq"'

	-- 'recommended = false' is Part of Autopairs integration below
	-- <C-Space> not recognised on terminal in windows so re-mapped to F3
	keymap = { recommended = false, manual_complete = '<F3>' },

	['display.preview.border'] = 'double',
	['display.ghost_text.context'] = { '', '' },

	-- Snippets seem to block lsp more than be useful, disabled for now
	['clients.snippets'] = {
		enabled = false,
	},
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

lsp = require('lspconfig')
coq = require('coq')

function SelectSnippetParameterFromInsert()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc><C-h>', true, false, true), 'i', true)
end
