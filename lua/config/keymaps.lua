local function map(m, k, v)
	vim.keymap.set(m, k, v, { noremap = true, silent = true })
end

-- Set leader
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Nvim-tree
map("n", "<leader>t", ":NvimTreeOpen<CR>")
map("n", "<C-n>", ":NvimTreeClose<CR>")
