require('dap-python').setup('C:\\Python310\\python.exe')
table.insert(require('dap').configurations.python, {
   type = 'python',
   request = 'launch',
   program = '${file}',
   console = 'integratedTerminal',
   name = 'Launch file with autoReload',
   justMyCode = false,
   autoReload = {
      enable = true,
   },
})
