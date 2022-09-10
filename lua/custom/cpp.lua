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
