function FlipBoolean()
   local currentWord = vim.call('expand', '<cword>')

   local booleans = { 'True', 'False', 'true', 'false' }
   local inverse = { 'False', 'True', 'false', 'true' }

   for value = 1, 4 do
      if currentWord == booleans[value] then
         vim.cmd('normal! ciw' .. inverse[value])
         return
      end
   end
end
