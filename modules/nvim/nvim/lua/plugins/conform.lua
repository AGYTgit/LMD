local modName = "[Conform] "

return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				rust = { "rustfmt" },
				c = { "clang_format" },
				sh = { "shfmt" },
				yaml = { "prettier" },
				json = { "prettier" },
				toml = { "taplo" },
				lua = { "stylua" },
			},
		})
	end,
	keys = {
		{ "<leader>f", function() require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 500 }) end, mode = "n", desc = modName .. "Format file" },
	},
}
