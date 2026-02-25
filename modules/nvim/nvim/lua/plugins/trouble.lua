return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("trouble").setup({})

		vim.diagnostic.config({
			virtual_text = {
				prefix = "●",
				spacing = 4,
			},
			float = {
				border = "rounded",
			},
		})
	end,
}
