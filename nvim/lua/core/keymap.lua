-- bind : to ;
vim.cmd([[
    noremap : ;
    noremap ; :
]])


vim.g.mapleader = " "

local k = vim.keymap

-- clear search
k.set("n", "<leader>h", ":nohl<CR>", { desc = "Clear search highlights" })

-- create/close split
k.set("n", "<leader>sh", "<C-w>v", { desc = "Split horizontally" })
k.set("n", "<leader>sv", "<C-w>s", { desc = "Split vertically" })
k.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
