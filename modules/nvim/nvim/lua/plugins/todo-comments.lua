return {
	"folke/todo-comments.nvim",
	event = "BufReadPost",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("todo-comments").setup({
			signs = true,
			keywords = {
				TODO = { icon = "", color = "info" },
				NOTE = { icon = "", color = "hint" },
				WARN = { icon = "", color = "warning" },
				HACK = { icon = "", color = "warning" },
				BUG = { icon = "", color = "error", alt = { "ISSUE", "ERROR", "FIXME" } },
			},
		})
	end,
}
