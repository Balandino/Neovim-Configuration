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
