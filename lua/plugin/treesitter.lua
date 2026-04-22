local filetypes = {
	"vim",
	"lua",
	"c",
	"cpp",
	"javascript",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"asm",
	"bash",
	"cmake",
	"html",
	"css",
	"csv",
	"comment",
	"diff",
	"json",
	"latex",
	"make",
	"python",
	"xml",
	"yaml",
	"toml",
	"jsdoc",
	"json",
	"json5",
	"http",
	"markdown",
	"markdown_inline",
	"printf",
	"regex",
	"sql",
	"terraform",
	"hcl",
	"hcl",
	"go",
	"gotmpl",
	"dockerfile",
	"helm",
	"groovy",
}

require("nvim-treesitter").install(filetypes)

vim.treesitter.language.register("hcl", "terraform-vars")

vim.api.nvim_create_autocmd("FileType", {
	pattern = vim.list_extend(vim.deepcopy(filetypes), { "terraform-vars" }),
	callback = function()
		vim.treesitter.start()
	end,
})
