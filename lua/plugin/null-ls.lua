local syluaConfig
if vim.fn.has('win64') == 1 then
	syluaConfig = 'C:/Lua_Formatter/stylua.toml'
else
	syluaConfig = '/home/mkg/coding/lua_formatter/stylua.toml'
end

require('null-ls').setup({
	debug = false,
	sources = {
		require('null-ls').builtins.formatting.clang_format.with({
			disabled_filetypes = { 'java' },
			filetypes = { 'c', 'cpp', 'cs' },
		}),
		require('null-ls').builtins.formatting.stylua.with({
			extra_args = { '--config-path', syluaConfig },
		}),
		require('null-ls').builtins.formatting.prettierd.with({
			filetypes = { 'css' },
		}),
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
		end
	end,
})
