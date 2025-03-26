require("nvim-treesitter.configs").setup({
   ensure_installed = { "vim", "lua", "c", "cpp", "javascript", "php", "phpdoc", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "asm", "bash", "c_sharp", "cmake", "html", "css", "csv", "comment", "diff", "json", "latex", "make", "python", "xml", "yaml", "toml", "jsdoc", "http", "markdown", "markdown_inline", "printf", "regex", "sql", "terraform" },
   highlight = {
      enable = true,
   },
   auto_install = true,
   sync_install = false,
   ignore_install = {},
   modules = {},
   tree_docs = {
      enable = true,
   },
   textobjects = {
      select = {
         enable = true,

         -- Automatically jump forward to textobj, similar to targets.vim
         lookahead = true,

         keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
         },
         -- You can choose the select mode (default is charwise 'v')
         --
         -- Can also be a function which gets passed a table with the keys
         -- * query_string: eg '@function.inner'
         -- * method: eg 'v' or 'o'
         -- and should return the mode ('v', 'V', or '<c-v>') or a table
         -- mapping query_strings to modes.
         -- selection_modes = {
         -- 	["@parameter.outer"] = "v", -- charwise
         -- 	["@function.outer"] = "V", -- linewise
         -- 	["@class.outer"] = "<c-v>", -- blockwise
         -- },
         -- If you set this to `true` (default is `false`) then any textobject is
         -- extended to include preceding or succeeding whitespace. Succeeding
         -- whitespace has priority in order to act similarly to eg the built-in
         -- `ap`.
         --
         -- Can also be a function which gets passed a table with the keys
         -- * query_string: eg '@function.inner'
         -- * selection_mode: eg 'v'
         -- and should return true of false
         include_surrounding_whitespace = true,
      },
      move = {
         enable = true,
         set_jumps = true, -- whether to set jumps in the jumplist
         goto_next_start = {
            ["]f"] = "@function.outer",
            ["<a-]>"] = "@function.outer",
         },
         goto_next_end = {
            ["]F"] = "@function.outer",
         },
         goto_previous_start = {
            ["[f"] = "@function.outer",
            ["<a-[>"] = "@function.outer",
         },
         goto_previous_end = {
            ["[F"] = "@function.outer",
         },
         -- Below will go to either the start or the end, whichever is closer.
         -- Use if you want more granular movements
         -- Make it even more gradual by adding multiple queries and regex.
         -- goto_next = {
         -- 	["]d"] = "@conditional.outer",
         -- },
         -- goto_previous = {
         -- 	["[d"] = "@conditional.outer",
         -- },
      },
   },
})
