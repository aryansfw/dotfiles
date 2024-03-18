return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		return require("aryan.plugins.lualine")
	end,
	config = function()
		require("lualine").setup({
			options = {
				theme = "catppuccin",
			},
		})
	end,
}
