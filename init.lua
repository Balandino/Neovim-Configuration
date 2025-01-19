require("custom.flip_boolean")
require("config.options")
require("config.keymap")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
   {
      "sainnhe/gruvbox-material",
      lazy = false,
      priority = 1000,
      config = function()
         vim.g.gruvbox_material_foreground = "medium"
         vim.g.gruvbox_material_float_style = "dim"
         vim.cmd.colorscheme("gruvbox-material")
      end,
   },
   {
      "akinsho/bufferline.nvim",
      dependencies = {
         "kyazdani42/nvim-web-devicons",
      },
      config = function()
         require("plugin.bufferline")
      end,
   },
   {
      "leafOfTree/vim-matchtag",
      filetype = { "php", "html" },
      config = function()
         vim.g.vim_matchtag_enable_by_default = 0
         vim.g.vim_matchtag_files = "*.php,*.html"
      end,
   },
   {
      "kosayoda/nvim-lightbulb",
      event = "VeryLazy",
      config = function()
         require("plugin.action")
      end,
   },
   {
      "danymat/neogen",
      dependencies = "nvim-treesitter/nvim-treesitter",
      event = "VeryLazy",
      config = function()
         require("neogen").setup({})
      end,
   },
   -- {
   --    "lewis6991/gitsigns.nvim",
   --    event = "VeryLazy",
   --    config = function()
   --       require("gitsigns").setup()
   --    end
   -- },
   {
      "phelipetls/jsonpath.nvim",
      event = "VeryLazy",
      filetype = "json",
      config = function()
         require("plugin.json")
      end,
   },
   {
      "ThePrimeagen/refactoring.nvim",
      event = "VeryLazy",
      config = function()
         require("plugin.refactor")
      end,
   },
   {
      "folke/trouble.nvim",
      event = "VeryLazy",
      config = function()
         require("plugin.trouble")
      end,
   },
   {
      "ray-x/lsp_signature.nvim",
      -- event = "VeryLazy",
      config = function()
         -- require("plugin.lsp-signature")
      end,
   },
   {
      "aznhe21/actions-preview.nvim",
      -- Config is a keymapping set in keymaps area
   },
   {
      "mfussenegger/nvim-dap",
      event = "VeryLazy",
      dependencies = {
         "rcarriga/nvim-dap-ui",
         "mfussenegger/nvim-dap-python",
         "theHamsta/nvim-dap-virtual-text",
         "nvim-neotest/nvim-nio"
      },
      config = function()
         require("plugin.dap-ui")
         require("plugin.dap-configs")
         require("plugin.dap-virtual")
      end,
   },
   {
      "norcalli/nvim-colorizer.lua",
      config = function()
         require("plugin.colorizer")
      end,
   },
   {
      "williamboman/mason.nvim",
      lazy = false,
      priority = 1000,
      build = ":MasonUpdate",
      dependencies = {
         "neovim/nvim-lspconfig",
      },
      config = function()
         require("plugin.mason")
      end,
   },
   {
      "williamboman/mason-lspconfig.nvim",
      event = "VeryLazy",
      config = function()
         require("plugin.mason-lspconfig")
      end,
   },
   {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      event = "VeryLazy",
      config = function()
         require("plugin.mason-tool-installer")
         vim.cmd("MasonToolsUpdate")
      end,
   },
   {
      "nvim-treesitter/nvim-treesitter",
      build = { ":TSUpdate" },
      dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
      config = function()
         require("plugin.treesitter")
      end,
   },
   {
      "HiPhish/rainbow-delimiters.nvim",
      config = function()
         require("plugin.rainbow")
      end,
   },
   {
      "smoka7/hop.nvim",
      event = "VeryLazy",
      config = function()
         require("hop").setup({
            case_insensitive = false,
         })

         vim.cmd("hi HopNextKey guifg=#fb007a")
         vim.cmd("hi HopNextKey1 guifg=#fb007a")
         -- vim.cmd("hi HopNextKey1 guifg=#00eeff")
         vim.cmd("hi HopNextKey2 guifg=#fb007a")
         -- vim.cmd("hi HopNextKey2 guifg=#2a8fb8")
      end,
   },
   {
      "karb94/neoscroll.nvim",
      event = "VeryLazy",
      config = function()
         require("plugin.neoscroll")
      end,
   },
   {
      "windwp/nvim-ts-autotag",
      event = "InsertEnter",
      filetype = { "html", "php" },
      config = function()
         require("nvim-ts-autotag").setup()
      end,
   },
   {
      "wellle/targets.vim",
      event = "VeryLazy",
   },
   {
      "anuvyklack/hydra.nvim",
      event = "VeryLazy",
      config = function()
         require("plugin.hydra")
      end,
   },
   {
      "akinsho/toggleterm.nvim",
      event = "VeryLazy",
      dependencies = {
         "kyazdani42/nvim-web-devicons",
      },
      config = function()
         require("plugin.toggleterm")
      end,
   },
   {
      "kylechui/nvim-surround",
      version = "*",
      event = "VeryLazy",
      config = function()
         require("nvim-surround").setup()
      end,
   },
   {
      "kyazdani42/nvim-tree.lua",
      VeryLazy = true,
      dependencies = {
         "kyazdani42/nvim-web-devicons",
      },
      config = function()
         require("plugin.nvim-tree")
      end,
   },
   {
      "nvim-neotest/neotest",
      lazy = true,
      dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-treesitter/nvim-treesitter",
         "antoinemadec/FixCursorHold.nvim",
         "nvim-neotest/neotest-python",
      },
      config = function()
         require("plugin.neotest")
      end,
   },
   {
      "nvim-lualine/lualine.nvim",
      config = function()
         require("plugin.lualine")
      end,
   },
   {
      "terrortylor/nvim-comment",
      event = "VeryLazy",
      config = function()
         require("plugin.nvim-comment")
      end,
   },
   {
      "stevearc/conform.nvim",
      config = function()
         require("plugin.conform")
      end,
   },
   { "cohama/lexima.vim" },
   {
      "hrsh7th/nvim-cmp",
      -- lazy = true,
      event = "InsertEnter",
      dependencies = {
         "neovim/nvim-lspconfig",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "amarakon/nvim-cmp-buffer-lines",
         "hrsh7th/cmp-cmdline",
         "rcarriga/cmp-dap",
         {
            "L3MON4D3/LuaSnip",
            dependencies = {
               "rafamadriz/friendly-snippets",
            },
         },
         "saadparwaiz1/cmp_luasnip",
         "hrsh7th/cmp-nvim-lsp-document-symbol",
         "hrsh7th/cmp-nvim-lsp-signature-help",
         "hrsh7th/cmp-nvim-lua",
         "petertriho/cmp-git",
         "onsails/lspkind.nvim",
      },
      config = function()
         require("luasnip.loaders.from_vscode").lazy_load()
         require("plugin.cmp")
      end,
   },
   {
      "nvim-telescope/telescope.nvim",
      event = "VeryLazy",
      dependencies = {
         "kyazdani42/nvim-web-devicons",
         "nvim-lua/plenary.nvim",
         "nvim-lua/popup.nvim",
         "nvim-telescope/telescope-ui-select.nvim",
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
         },
      },
      config = function()
         require("plugin.telescope")
      end,
   },
}

local config = require("plugin.lazy")
require("lazy").setup(plugins, config)
require("plugin.lsp")


-- -------------------------------------------------------------------------------------------------------------------------------
-- Prevents highlighting showing when sourcing $MYVIMRC
-- -------------------------------------------------------------------------------------------------------------------------------
-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":noh<CR>:echo<CR>", true, false, true), "n", true)
