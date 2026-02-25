return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				rust = { "rustfmt" },
				c = { "clang_format" },
				java = { "google-java-format" },
				sh = { "shfmt" },
				yaml = { "prettier" },
				json = { "prettier" },
				toml = { "taplo" },
				lua = { "stylua" },
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format()
		end, { desc = "Format file" })
	end,
}
