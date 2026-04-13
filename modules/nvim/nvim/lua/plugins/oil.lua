local modName = "[Oil] "

return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["q"] = "actions.close",
			},
			float = {
				padding = 2,
				max_width = 100,
				max_height = 30,
				border = "rounded",
			},
		})
	end,
	keys = {
		{ "<leader>o", function() require("oil").toggle_float() end, mode = "n", desc = modName .. "Oil menu" },
	},
}
