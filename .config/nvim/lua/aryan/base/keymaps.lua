local function map(m, k, v, desc)
	local opt = vim.tbl_extend("force", { noremap = true, silent = true }, { desc = desc })
	vim.keymap.set(m, k, v, opt)
end

-------- General --------

map("", "<Space>", "<Nop>", "Set space as leader key")
vim.g.mapleader = " "

-- Modes :h map-modes
--    normal = "n"
--    insert = "i"
--    visual = "v"
--    visual_block = "x"
--    term = "t"
--    command = "c

-- Normal Mode --
map("n", "<C-h>", "<C-w>h", "Navigate to window left of current")
map("n", "<C-j>", "<C-w>j", "Navigate to window under current")
map("n", "<C-k>", "<C-w>k", "Navigate to window above current")
map("n", "<C-l>", "<C-w>l", "Navigate to window right of current")

map("n", "<S-h>", ":bprevious<CR>", "Go to previous buffer")
map("n", "<S-l>", ":bnext<CR>", "Go to next buffer")
map("n", "j", "gj", "Go up a line")
map("n", "k", "gk", "Go down a line")

-- Insert Mode --
map("i", "jj", "<Esc>", "Enter insert mode with jj")

-------- Plugins --------
-- telescope --
map("n", "<leader>ff", ":Telescope find_files<CR>", "Telescope find files") -- Find files
map("n", "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true<CR>", "Telescope find all")
map("n", "<leader>fb", ":Telescope buffers<CR>", "Telescope buffers")
map("n", "<leader>fg", ":Telescope live_grep<CR>", "Telescope live grep")
map("n", "<leader>fr", function()
	require("telescope.builtin").oldfiles({ only_cwd = true })
end, "Telescope recent files")

-- oil --
map("n", "-", ":Oil<CR>", "Open parent directory")

-- markdown-preview --
map("n", "<leader>pp", ":MarkdownPreview<CR>", "See markdown preview")

-- lazygit --
map("n", "<leader>gg", ":LazyGit<CR>", "Open lazy git ui")

-- which-key --
map("n", "<leader>wK", function()
	vim.cmd("WhichKey")
end, "Open which key")
map("n", "<leader>wk", function()
	local input = vim.fn.input("WhichKey: ")
	vim.cmd("WhichKey " .. input)
end, "Open which key for certain input")
