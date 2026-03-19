return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		require("which-key").setup({
			preset = "helix",
			icons = {
				mappings = true,
				keys = {
					Space = "󱁐",
					Up = "↑ ",
					Down = "↓ ",
					Left = "← ",
					Right = "→ ",
					C = "󰘴 ",
					M = "󰘵 ",
					S = "󰘶 ",
					CR = "󰌑 ",
					Esc = "󱊷 ",
					Tab = "󰌒 ",
					BS = "󱃩 ",
				},
			},
			spec = {
				{ "<leader>t", group = "Telescope" },
				{ "<leader>h", group = "Harpoon" },
				{ "<leader>q", group = "Session" },
				-- { "<leader>x", group = "Diagnostics" },
			},
		})
		vim.api.nvim_set_hl(0, "WhichKeyNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "WhichKeyBorder", { bg = "none" })
	end,
}
