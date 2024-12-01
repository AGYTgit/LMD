-- swap : and ;
vim.cmd([[
    noremap : ;
    noremap ; :
]])

local k = vim.keymap
vim.g.mapleader = " "

-- open explore
k.set("n", "<leader>e", ":Explore<CR>", { noremap = true, silent = true })

-- clear search
k.set("n", "<leader>h", ":nohl<CR>", { noremap = true, silent = true })

-- create split
k.set("n", "<leader>sh", "<C-w>v", { noremap = true, silent = true })
k.set("n", "<leader>sv", "<C-w>s", { noremap = true, silent = true })

-- contrlo split focus
k.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
k.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
k.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
k.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })