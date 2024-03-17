require("telescope").load_extension("ui-select")
-- require("telescope").load_extension("harpoon")

local options = {
	defaults = {
		initial_mode = "insert",
		layout_strategy = "center",
		layout_config = {
			center = {
				width = 0.9,
			},
			preview_cutoff = 1,
			height = 0.5,
		},
		preview = {
			hide_on_startup = true,
		},
		border = true,
		borderchars = {
			prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},
		mappings = {
			n = {
				["q"] = require("telescope.actions").close,
				["<C-b>"] = require("telescope.actions.layout").toggle_preview,
			},
			i = {
				["<C-b>"] = require("telescope.actions.layout").toggle_preview,
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_cursor(),
			},
		},
	},
}

return options
