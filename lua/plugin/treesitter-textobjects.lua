require("nvim-treesitter-textobjects").setup({
  move = {
    set_jumps = true,
  },
  select = {
     enable = true,
     lookahead = true,
  },
})


local move = require("nvim-treesitter-textobjects.move")

-- Visually select within a function
vim.keymap.set("x", "if", function()
  move.select_textobject("@function.inner", "textobjects")
end)

-- Visually select outside a function
vim.keymap.set("x", "af", function()
  move.select_textobject("@function.outer", "textobjects")
end)

-- Go to the next function
vim.keymap.set("n", "]f", function()
  move.goto_next_start("@function.outer", "textobjects")
end)

-- Go to the previous function
vim.keymap.set("n", "[f", function()
  move.goto_previous_start("@function.outer", "textobjects")
end)

-- Go to the end of the next function
vim.keymap.set("n", "]F", function()
  move.goto_next_end("@function.outer", "textobjects")
end)

-- Go to the end of the previous function
vim.keymap.set("n", "[F", function()
  move.goto_previous_end("@function.outer", "textobjects")
end)
