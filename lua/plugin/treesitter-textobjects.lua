-- Use the specific selection module instead of the move module
local ts_select = require("nvim-treesitter-textobjects.select")
local ts_move = require("nvim-treesitter-textobjects.move")

-- Visually select within a function
vim.keymap.set("x", "if", function()
	ts_select.select_textobject("@function.inner", "textobjects")
end)

-- Visually select outside a function
vim.keymap.set("x", "af", function()
	ts_select.select_textobject("@function.outer", "textobjects")
end)

-- Delete within a function
vim.keymap.set("o", "if", function()
	ts_select.select_textobject("@function.inner", "textobjects")
end)

-- Delete outside a function
vim.keymap.set("o", "af", function()
	ts_select.select_textobject("@function.outer", "textobjects")
end)

-- Jump to next/previous function
vim.keymap.set("n", "]f", function()
	ts_move.goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set("n", "[f", function()
	ts_move.goto_previous_start("@function.outer", "textobjects")
end)

-- Jump to next/previous function end
vim.keymap.set("n", "]F", function()
	ts_move.goto_next_end("@function.outer", "textobjects")
end)
vim.keymap.set("n", "[F", function()
	ts_move.goto_previous_end("@function.outer", "textobjects")
end)
