return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")

		require("statuscol").setup({
			setopt = true,
			relculright = true,
			segments = {
				{ sign = { name = { ".*" }, namespace = { ".*" } }, click = "v:lua.ScSa" },
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				{ sign = { namespace = { "gitsigns.*" } }, click = "v:lua.ScSa" },
			},
		})
	end,
}
