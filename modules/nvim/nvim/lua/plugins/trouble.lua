local modName = "[Trouble] "

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
	keys = {
		{ "<leader>x", "<cmd>Trouble diagnostics toggle<cr>", mode = "n", desc = modName .. "Toggle diagnostics" },
		{ "<leader>e", vim.diagnostic.open_float, mode = "n", desc = modName .. "Expand hovered diagnostics" },
		{ "]-", function() vim.diagnostic.jump({ count = 1 }) end, mode = "n", desc = modName .. "Next diagnostic" },
		{ "]+", function() vim.diagnostic.jump({ count = -1 }) end, mode = "n", desc = modName .. "Prev diagnostic" },
		-- { "}-", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, mode = "n", desc = modName .. "Next error" },
		-- { "}+", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, mode = "n", desc = modName .. "Prev error" },
	},
}
