require('trouble').setup({
   cmd = "Trouble",
   modes = {
      diagnostics = { -- Configure symbols mode
         win = {
            -- type = "split",      -- split window
            -- relative = "win",    -- relative to current window
            position = "bottom", -- right side
            size = 0.35,         -- 30% of the window
         },
         preview = {
            type = "split",
            relative = "win",
            position = "right",
            size = 0.5,
         },
      },
   },
})
