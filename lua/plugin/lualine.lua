local function getLsps()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return "[]"
	end

	local seen = {}
	local uniqueNames = {}
	for _, client in pairs(clients) do
		if not seen[client.name] then
			table.insert(uniqueNames, client.name)
			seen[client.name] = true
		end
	end
	-- table.concat is much cleaner than manual string slicing!
	return "[" .. table.concat(uniqueNames, ", ") .. "]"
end

local saved = function()
	return vim.bo.modified and "󰆓" or ""
end

local function getTotalLines()
	return vim.fn.line("$")
end

local tabs = {
	"tabs",
	tab_max_length = 40, -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
	max_length = vim.o.columns / 3, -- Maximum width of tabs component.
	-- Note:
	-- It can also be a function that returns
	-- the value of `max_length` dynamically.
	mode = 1, -- 0: Shows tab_nr
	-- 1: Shows tab_name
	-- 2: Shows tab_nr + tab_name

	path = 0, -- 0: just shows the filename
	-- 1: shows the relative path and shorten $HOME to ~
	-- 2: shows the full path
	-- 3: shows the full path and shorten $HOME to ~

	-- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
	use_mode_colors = false,

	tabs_color = {
		-- Same values as the general color option can be used here.
		active = "red", -- Color for active tab.
		inactive = "white", -- Color for inactive tab.
	},

	show_modified_status = true, -- Shows a symbol next to the tab name if the file has been modified.
	symbols = {
		modified = "[+]", -- Text to show when the file is modified.
	},

	fmt = function(name, context)
		-- Show + if buffer is modified in tab
		local buflist = vim.fn.tabpagebuflist(context.tabnr)
		local winnr = vim.fn.tabpagewinnr(context.tabnr)
		local bufnr = buflist[winnr]
		local mod = vim.fn.getbufvar(bufnr, "&mod")

		return name .. (mod == 1 and " +" or "")
	end,
}

local diagnostics = {
	"diagnostics",
	-- sources = { "nvim_diagnostic", "nvim_lsp", "nvim_workspace_diagnostic", "vim_lsp" },
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = {
		error = "E",
		hint = "H",
		info = "I",
		warn = "W",
	},
	colored = true,
	update_in_insert = false,
	always_visible = true,
}

local gruvbox_theme = require("lualine.themes.gruvbox")

-- Helper to create transparent mode configs
local function create_transparent_mode(fg_a)
	return {
		a = { bg = "None", fg = fg_a, gui = "bold" },
		b = { bg = "None", fg = gruvbox_theme.light4 },
		c = { bg = "None", fg = gruvbox_theme.light4 },
		x = { bg = "None", fg = gruvbox_theme.light4 },
		y = { bg = "None", fg = gruvbox_theme.light4 },
		z = { bg = "None", fg = fg_a },
	}
end

local custom_gruvbox = {
	normal = create_transparent_mode(gruvbox_theme.light4),
	insert = create_transparent_mode(gruvbox_theme.bright_blue),
	visual = create_transparent_mode(gruvbox_theme.bright_yellow),
	replace = create_transparent_mode(gruvbox_theme.bright_red),
	command = create_transparent_mode(gruvbox_theme.bright_green),
	inactive = create_transparent_mode(gruvbox_theme.light4),
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = custom_gruvbox,
		-- theme = "gruvbox",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
	},

	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { diagnostics, tabs },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { getLsps, saved },
		lualine_z = { "location", "progress", getTotalLines },
	},

	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},

	tabline = {},
})
