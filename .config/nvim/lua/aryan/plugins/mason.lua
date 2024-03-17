local M = {}

M.mason = {
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
}

M.mason_lspconfig = {
	ensure_installed = {
		"tsserver",
	},
	automatic_installation = true,
}

return M
