local options = {
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		lua = { "stylua" },
	},

	format_on_save = {
		lsp_fallback = true,
		timeout_ms = 500,
		async = false,
	},
}

return options
