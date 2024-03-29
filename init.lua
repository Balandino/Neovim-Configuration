require("custom.flip_boolean")
require("config.options")
require("config.keymap")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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
      "sainnhe/everforest",
      lazy = false,
      priority = 1000,
      config = function()
         -- vim.opt.bg = "light"
         -- vim.g.everforest_background = 'hard' -- hard / medium / soft
         -- vim.cmd.colorscheme("everforest")
      end,
   },
   {
      "dotsilas/darcubox-nvim",
      config = function()
         -- vim.cmd("colorscheme darcubox")
      end,
   },
   {
      "gruvbox-community/gruvbox",
      config = function()
         -- vim.cmd.colorscheme("gruvbox")
      end,
   },
   {
      "arturgoms/moonbow.nvim",
      event = "VeryLazy",
      config = function()
         -- vim.cmd.colorscheme("moonbow")
      end,
   },
   {
      "akinsho/bufferline.nvim",
      -- event = "VeryLazy", -- Faster but bufferline 'pops' in after loading
      event = "BufEnter",
      dependencies = {
         "kyazdani42/nvim-web-devicons",
      },
      config = function()
         require("plugin.bufferline")
      end,
   },
   {
      "leafOfTree/vim-matchtag",
      config = function()
         vim.g.vim_matchtag_enable_by_default = 0
         vim.g.vim_matchtag_files = "*.php,*.html"
      end,
   },
   {
      "lewis6991/spaceless.nvim",
      config = function()
         require("spaceless").setup()
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
   {
      "lewis6991/gitsigns.nvim",
      config = function()
         require("gitsigns").setup()
      end
   },
   {
      "phelipetls/jsonpath.nvim",
      event = "VeryLazy",
      config = function()
         require("plugin.json")
      end,
   },
   -- {
   -- 	"mfussenegger/nvim-jdtls",
   -- 	config = function()
   -- 		require("plugin.jdtls")
   -- 	end,
   -- },
   {
      "ThePrimeagen/refactoring.nvim",
      event = "VeryLazy",
      config = function()
         require("plugin.refactor")
      end,
   },
   {
      "rareitems/printer.nvim",
      event = "VeryLazy",
      config = function()
         require("printer").setup({
            keymap = "gp", -- Plugin doesn't have any keymaps by default
         })
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
      -- event = "VeryLazy",
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
      "folke/neodev.nvim",
      event = "VeryLazy",
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
   -- https://github.com/HiPhish/rainbow-delimiters.nvim/issues/2
   {
      "HiPhish/rainbow-delimiters.nvim",
      config = function()
         require("plugin.rainbow")
      end,
   },
   {
      "mbbill/undotree",
      event = "VeryLazy",
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
      "kg8m/vim-simple-align",
      event = "VeryLazy",
   },
   {
      "karb94/neoscroll.nvim",
      event = "VeryLazy",
      config = function()
         require("plugin.neoscroll")
      end,
   },
   {
      -- Lazy loading breaks plugin
      "windwp/nvim-ts-autotag",
      config = function()
         require("nvim-ts-autotag").setup()
      end,
   },
   {
      "wellle/targets.vim",
      event = "VeryLazy",
   },
   {
      "simrat39/symbols-outline.nvim",
      event = "VeryLazy",
      config = function()
         require("plugin.symbols-outline")
      end,
   },
   {
      "anuvyklack/hydra.nvim",
      event = "VeryLazy",
      config = function()
         require("plugin.hydra")
      end,
   },
   {
      "folke/trouble.nvim",
      lazy = true,
      config = function()
         require("plugin.trouble")
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
      lazy = true,
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
      "goolord/alpha-nvim",
      dependencies = {
         "kyazdani42/nvim-web-devicons",
      },
      config = function()
         require("plugin.alpha")
      end,
   },
   {
      "nvim-lualine/lualine.nvim",
      event = "VeryLazy",
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
   {
      "windwp/nvim-autopairs",
      config = function()
         require("nvim-autopairs").setup()
      end,
   },
   {
      "hrsh7th/nvim-cmp",
      lazy = true,
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
         "metalelf0/nvim-floatedit",
         "nvim-telescope/telescope-ui-select.nvim",
         "metalelf0/nvim-floatedit",
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
-- require("plugin.jdtls") -- Uncomment along with plugin to re-activate

-- -------------------------------------------------------------------------------------------------------------------------------
-- Prevents highlighting showing when sourcing $MYVIMRC
-- -------------------------------------------------------------------------------------------------------------------------------
-- vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":noh<CR>:echo<CR>", true, false, true), "n", true)
