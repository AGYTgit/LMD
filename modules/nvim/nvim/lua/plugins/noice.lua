return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("noice").setup({
			cmdline = {
				view = "cmdline_popup",
				opts = {
					position = {
						row = "8%",
						col = "50%",
					},
				},
			},
		})
	end,
}
