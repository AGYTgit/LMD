local modName = "[Snacks] "

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("snacks").setup({
			indent = { enabled = true },
			notifier = { enabled = true },
			bigfile = { enabled = true },
			quickfile = { enabled = true },
			words = { enabled = true },
			bufdelete = { enabled = true },
			input = { enabled = true },
			picker = {
				enabled = true,
				win = {
					input = {
						-- keys = {
						-- 	["<leader><esc>"] = { "close", mode = { "i", "n" }, desc = modName .. "Close popup" },
						-- },
					},
					wo = {
						signcolumn = "no",
					},
				},
			},
		})
	end,
	keys = {
		{ "<leader>n", function() require("snacks").notifier.show_history() end, mode = "n", desc = modName .. "Notification popup" },
	},
}
