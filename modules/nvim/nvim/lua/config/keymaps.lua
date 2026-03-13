local modName = "[Vim] "

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local function map(modes, lhs, rhs, opts)
	vim.keymap.set(modes, lhs, rhs, opts or {})
end

-- swap : with ;
map({ "n", "v" }, ";", ":")
map({ "n", "v" }, ":", ";")

-- center cursor after jump
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "j", "jzz")
map("n", "k", "kzz")
map("n", "<S-g>", "<S-g>zz")
map("n", "n", "nzz")
map("n", "<S-n>", "<S-n>zz")

-- lazy menu
map({ "n" }, "<leader>l", "<cmd>Lazy<CR>")

-- cancel highlight
map("n", "<esc>", "<cmd>nohlsearch<cr>")

-- preserve select after </>
map("v", "<", "<gv")
map("v", ">", ">gv")

-- move selected lines
map("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })
