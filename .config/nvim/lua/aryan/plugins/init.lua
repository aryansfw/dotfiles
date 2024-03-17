local plugins = {
	-- catppuccin --
	{
		"catppuccin/nvim",
		opts = function()
			return require("aryan.plugins.catppuccin")
		end,
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- vim-tmux-navigator --
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	-- nvim-colorizer --
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true,
				},
			})
		end,
	},

	-- nvim-web-devicons --
	{
		"nvim-tree/nvim-web-devicons",
		config = function(_, opts)
			require("nvim-web-devicons").setup(opts)
		end,
	},

	-- lualine --
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return require("aryan.plugins.lualine")
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},

	-- telescope --
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		opts = function()
			return require("aryan.plugins.telescope")
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
		end,
	},

	-- harpoon --
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("aryan.plugins.harpoon")
		end,
	},

	-- oil --
	{
		"stevearc/oil.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		options = function()
			return require("aryan.plugins.oil")
		end,
		config = function()
			require("oil").setup()
		end,
	},

	-- Comment --
	{
		"numToStr/Comment.nvim",
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},

	-- indent-blankline --
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = function()
			return require("aryan.plugins.indent_blankline")
		end,
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},

	-- autotag --
	{
		"windwp/nvim-ts-autotag",
		config = function(_, opts)
			require("nvim-ts-autotag").setup(opts)
		end,
	},

	-- nvim-treesitter --
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = function()
			return require("aryan.plugins.nvim_treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	---- Language Server Protocol (LSP) ---- mason, mason-lspconfig, nvim-lspconfig
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		opts = function()
			return require("aryan.plugins.mason")
		end,
		config = function(_, opts)
			require("mason").setup(opts.mason)
			require("mason-lspconfig").setup(opts.mason_lspconfig)
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("aryan.plugins.lspconfig")
		end,
	},

	---- Formatter ----
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			return require("aryan.plugins.conform")
		end,
		config = function(_, opts)
			require("conform").setup(opts)
		end,
	},

	---- Linter ----
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("aryan.plugins.linting")
		end,
	},

	---- cmp ----
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"windwp/nvim-autopairs",
				opts = {
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
				end,
			},
			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
			},
		},
		opts = function()
			return require("aryan.plugins.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},

	---- Github ----
	{
		"kdheepak/lazygit.nvim",
		cmd = "LazyGit",
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},

	---- Markdown ----
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	---- which-key ----
	{
		"folke/which-key.nvim",
		lazy = true,
		cmd = "WhichKey",
		config = function(_, opts)
			require("which-key").setup(opts)
		end,
	},
}

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

local config = require("aryan.plugins.lazy_nvim")
require("lazy").setup(plugins, config)
