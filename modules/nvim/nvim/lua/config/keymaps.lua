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

-- lazy menu
map({ "n" }, "<leader>l", "<cmd>Lazy<CR>")

-- telescope
map({ "n" }, "<leader><leader>", "<cmd>Telescope find_files<CR>")
map({ "n" }, "<leader>/", "<cmd>Telescope live_grep<CR>")
map({ "n" }, "<leader>h", "<cmd>Telescope keymaps<CR>")
map({ "n" }, "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Search todos" })

-- snacks notification
map("n", "<leader>n", function()
	Snacks.notifier.show_history()
end, { desc = "Notification history" })

-- trouble diagnostics
map("n", "<leader>x", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
map("n", "}-", function()
	vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })
map("n", "}+", function()
	vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })
map("n", "]-", function()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next error" })
map("n", "]+", function()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev error" })

-- lsp
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })

-- cancel highlight
map("n", "<esc>", "<cmd>nohlsearch<cr>")

-- preserve select after </>
map("v", "<", "<gv")
map("v", ">", ">gv")
