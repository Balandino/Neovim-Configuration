-- require("dap-python").setup("C:\\Python312\\python.exe")
-- return vim.fn.has("win32") == 1

require("dap-python").setup(vim.fn.getcwd() .. "\\Scripts\\" .. "python.exe")
table.insert(require("dap").configurations.python, {
	type = "python",
	request = "launch",
	program = "${file}",
	console = "integratedTerminal",
	name = "Launch file with autoReload",
	justMyCode = false,
	autoReload = {
		enable = true,
	},
})

require("dap-python").resolve_python = function()
	return vim.fn.getcwd() .. "\\Scripts\\" .. "python.exe"
end

require("dap").adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	-- command = "C:\\Neovim Storage\\cpptools-win64\\extension\\debugAdapters\\bin\\OpenDebugAD7.exe",
	-- https://harrisoncramer.me/debugging-in-neovim/
	command = vim.fn.stdpath("data") .. "\\mason\\bin\\OpenDebugAD7.cmd",
	options = {
		detached = false,
	},
}

-- Possibly works if you know what you're doing
require("dap").configurations.c = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			-- return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			return vim.fn.input({ prompt = "Path to executable: ", default = vim.fn.getcwd() .. "\\" })
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
		miDebuggerPath = "C:\\ProgramData\\chocolatey\\lib\\winlibs\\tools\\mingw64\\bin\\gdb.exe",
		setupCommands = {
			{
				text = "-enable-pretty-printing",
				description = "enable pretty printing",
				ignoreFailures = false,
			},
		},
	},
}
