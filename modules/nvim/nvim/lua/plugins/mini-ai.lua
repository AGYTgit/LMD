return {
	"echasnovski/mini.ai",
	event = "VeryLazy",
	config = function()
		require("mini.ai").setup({
			n_lines = 500,
		})
	end,
}
