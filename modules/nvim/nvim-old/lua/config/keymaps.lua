-- swap : and ;
vim.cmd([[
    noremap : ;
    noremap ; :
]])

local k = vim.keymap

vim.g.mapleader = ","

-- delete comment -- needs a fix, deletes more then it should if there is no space before the comment, also works only for / as a start of the comment indicator
k.set("n", "<leader>dc", "0f/v$hxviwx", { noremap = true, silent = true })

-- clear search
k.set("n", "<leader>h", "<cmd>nohl<CR>", { noremap = true, silent = true })

-- create split
k.set("n", "<leader>sh", "<C-w>v", { noremap = true, silent = true })
k.set("n", "<leader>sv", "<C-w>s", { noremap = true, silent = true })

-- open nvim-tree
k.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- telescope
vim.g.telescope_key = " "
k.set("n", vim.g.telescope_key .. "f", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
k.set("n", vim.g.telescope_key .. "g", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
k.set("n", vim.g.telescope_key .. "b", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
k.set("n", vim.g.telescope_key .. "h", "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
