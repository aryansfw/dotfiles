return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = function()
		return require("aryan.plugins.indent_blankline")
	end,
	config = function()
		require("ibl").setup({

			indent = {
				char = "▏",
			},
			scope = {
				show_start = false,
				show_end = false,
			},
		})
	end,
}
