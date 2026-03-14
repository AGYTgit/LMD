local modName = "[Vim] "

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local function map(modes, lhs, rhs, opts) vim.keymap.set(modes, lhs, rhs, opts or {}) end

-- swap : with ;
map({ "n", "v" }, ";", ":", { desc = modName .. "Swap ; with :" })
map({ "n", "v" }, ":", ";", { desc = modName .. "Swap : with ;" })

-- center cursor after jump
local param = " (with zz) "
map("n", "<C-d>", "<C-d>zz", { desc = modName .. "Jump down" .. param })
map("n", "<C-u>", "<C-u>zz", { desc = modName .. "Jump up" .. param })
map("n", "j", "jzz", { desc = modName .. "Move down" .. param })
map("n", "k", "kzz", { desc = modName .. "Move up" .. param })
map("n", "<S-g>", "<S-g>zz", { desc = modName .. "Jump to end" .. param })
map("n", "n", "nzz", { desc = modName .. "Jump to next match" .. param })
map("n", "<S-n>", "<S-n>zz", { desc = modName .. "Jump to prev match" .. param })

-- lazy menu
map({ "n" }, "<leader>l", "<cmd>Lazy<CR>", { desc = modName .. "Lazy menu" })

-- cancel highlight
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = modName .. "Hide search highlight" })

-- preserve select after </>
local param = " (preserve select) "
map("v", "<", "<gv", { desc = modName .. "Remove padding" .. param })
map("v", ">", ">gv", { desc = modName .. "Add padding" .. param })

-- move selected lines
map("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = modName .. "Move lines down" .. param })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = modName .. "Move lines up" .. param })
