require("aryan.base")
require("aryan.plugins")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- Bootstrap lazy.nvim
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://www.github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("aryan.plugins", {
	install = {
		colorscheme = { "catppuccin" },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"netrw",
				"netrwPlugin",
			},
		},
	},
})

vim.cmd("colorscheme catppuccin")
