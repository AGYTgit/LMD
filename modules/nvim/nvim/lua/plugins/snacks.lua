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
				nabled = true,
				win = {
					input = {
						keys = {
							["<esc>"] = { "close", mode = { "i", "n" } },
						},
					},
					wo = {
						signcolumn = "no",
					},
				},
			},
		})
	end,
}
