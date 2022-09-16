local function getLsps()
	local lspNames = '['
	for _, client in pairs(vim.lsp.buf_get_clients()) do
		lspNames = lspNames .. client.name .. ', '
	end

	return string.sub(lspNames, 1, string.len(lspNames) - 2) .. ']'
end

local function getTotalLines()
	return vim.fn.line('$')
end

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
		lualine_y = { getLsps },
		lualine_z = { getTotalLines, 'location', 'progress' },
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
