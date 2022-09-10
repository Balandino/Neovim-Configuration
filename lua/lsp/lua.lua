local sumneko_root_path = ''
local sumneko_binary = ''

if vim.fn.has('win64') == 1 then
	sumneko_root_path = 'C:/Users/Michael/AppData/Local/nvim-data/lsp_servers/sumneko_lua/extension/server/bin'
	sumneko_binary = 'C:/Users/Michael/AppData/Local/nvim-data/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server.exe'
elseif vim.fn.has('unix') == 1 then
	sumneko_root_path = '/home/mkg/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin'
	sumneko_binary = '/home/mkg/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/lua-language-server'
end
lsp.sumneko_lua.setup(coq.lsp_ensure_capabilities({
	cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
		},
	},
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false -- Prevents option showing when null-ls autoformats
		client.resolved_capabilities.document_range_formatting = false -- Prevents option showing when null-ls autoformats
	end,
}))
