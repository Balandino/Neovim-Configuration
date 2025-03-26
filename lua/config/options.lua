-- Prevent code folding upon file open
vim.api.nvim_create_augroup("folding", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
   group = "folding",
   pattern = "*",
   callback = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("zR", true, false, true), "n", true)
   end,
})

vim.api.nvim_create_autocmd("FileReadPost", {
   group = "folding",
   pattern = "*",
   callback = function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("zR", true, false, true), "n", true)
   end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
   pattern = { "*" },
   callback = function()
      local save_cursor = vim.fn.getpos(".")
      vim.cmd([[%s/\s\+$//e]])
      vim.fn.setpos(".", save_cursor)
   end,
})

vim.cmd("let &term = 'xterm-256color'") -- Unsure if still needed
vim.opt.termguicolors = true
vim.opt.bg = "dark"

vim.diagnostic.config { virtual_lines = true }

vim.opt.wildmenu = true
vim.opt.wildmode = "full"
vim.opt.hlsearch = true

vim.opt.signcolumn = "yes"
vim.opt.undofile = true
vim.opt.undodir = "C:\\Mega\\Coding\\Workpad\\Nvim_History"

vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.textwidth = 0
vim.opt.wrap = true
-- vim.opt.fileformat = 'unix' -- Prevents ^M appearing at end of lines on formatting (^M = \r sign on Windows?, use %s/\r//g to remove manually)
vim.opt.hidden = true

vim.opt.splitright = true

vim.opt.foldmethod = "expr"
-- vim.opt.foldnestmax = 1
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.cmd("set nofoldenable")


-- terminal settings
local powershell_options = {
   shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
   shellcmdflag =
   "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
   shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
   shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
   shellquote = "",
   shellxquote = "",
}

for option, value in pairs(powershell_options) do
   vim.opt[option] = value
end

vim.keymap.set('t', '<Esc>', "<C-\\><C-n>")
vim.keymap.set('t', '<C-w>', "<C-\\><C-n><C-w>")

-- Places yanks in system clipboard for pasting into other programs
-- Should still work with P in nvim
-- vim.opt.clipboard = 'unnamedplus'

-- vim.cmd("highlight Normal guibg=none") -- Makes the background transparent
-- if vim.fn.has('unix') == 1 then
-- if vim.fn.has("win32") == 1 then
