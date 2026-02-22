return {
	"folke/flash.nvim",
	event = "VeryLazy",
	config = function()
		require("flash").setup({})
		local colors = require("tokyonight.colors").setup()
		vim.api.nvim_set_hl(0, "FlashLabel", { bg = colors.cyan, fg = colors.bg_dark, bold = true })
	end,
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash treesitter",
		},
	},
}
