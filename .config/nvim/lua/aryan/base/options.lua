-- :help options
local o = vim.o

-- Clipboard --
o.clipboard = "unnamedplus"
vim.g.clipboard = {
	name = "wsl-clipboard",
	copy = {
		["+"] = "win32yank.exe -i --crlf",
		["*"] = "win32yank.exe -i --crlf",
	},
	paste = {
		["+"] = "win32yank.exe -o --lf",
		["*"] = "win32yank.exe -o --lf",
	},
}

o.cursorline = true

-- Tab and Indentation
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.smarttab = false

-- Search
o.incsearch = true
o.ignorecase = true
o.smartcase = true

-- Numbers
o.number = true
o.relativenumber = true
o.numberwidth = 2

-- Appearance
o.termguicolors = true
o.signcolumn = "yes"

-- Behaviour
o.undofile = true
o.splitbelow = true
o.splitbelow = true
o.whichwrap = "bs<>[]hl"
o.mouse = "a"
o.swapfile = false
o.wrap = true

-- Colorscheme
vim.o.background = "dark"
