local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local on_attach = function(client, bufnr)
	if client.name == "ruff_lsp" then
		client.server_capabilities.hoverProvider = false
	end
end

local capabilities = cmp_nvim_lsp.default_capabilities()

---- lua ----
lspconfig.lua_ls.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

---- typescript ----
lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"typescript",
		"javascript",
		"typescriptreact",
		"javascriptreact",
		"typescript.tsx",
	},
	root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
})

---- tailwindcss ----
lspconfig.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"typescriptreact",
		"typescript.tsx",
	},
})

---- markdown ----
lspconfig.marksman.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "marksman", "server" },
	filetypes = {
		"markdown",
		"markdown.mdx",
	},
	root_dir = lspconfig.util.root_pattern(".git", ".marksman.toml"),
})

---- python ----
-- lspconfig.ruff_lsp.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	filetypes = {
-- 		"python",
-- 	},
-- })

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"python",
	},
})
