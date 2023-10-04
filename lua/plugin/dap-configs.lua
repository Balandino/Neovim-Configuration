-- require("dap-python").setup("C:\\Python312\\python.exe")
-- return vim.fn.has("win32") == 1

-- https://github.com/mfussenegger/nvim-dap-python/issues/115
-- Replace
-- local is_windows = function()
--     return vim.loop.os_uname().sysname:find("Windows", 1, true) and true
-- end
--
-- With
-- local is_windows = function()
--   return vim.fn.has("win32") == 1
-- end

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

require("dap").adapters.chrome = {
   type = "executable",
   command = "node",
   args = { vim.fn.stdpath("data") .. "\\mason\\packages\\chrome-debug-adapter\\out\\src\\chromeDebug.js" },
}

require("dap").configurations.javascript = {
   {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
   },
}
-- chrome has to be started with a remote debugging port google-chrome-stable --remote-debugging-port=9222

-- local dap = require("dap")
-- dap.adapters.firefox = {
-- 	type = "executable",
-- 	command = "node",
-- 	args = { vim.fn.stdpath("data") .. "\\mason\\packages\\firefox-debug-adapter\\dist\\adapter.bundle.js" },
-- }

-- dap.configurations.javascript = {
-- 	{
-- 		name = "Debug with Firefox",
-- 		type = "firefox",
-- 		request = "launch",
-- 		reAttach = true,
-- 		url = "http://localhost:3000",
-- 		webRoot = "${workspaceFolder}",
-- 		firefoxExecutable = "path\\to\\firefox\\executable",
-- 	},
-- }

-- Remember to compile the program with debugging
-- $ cc -g factorial.c
-- $ gdb a.out
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
