return {
	"folke/tokyonight.nvim",
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			transparent = true,
			styles = {
				floats = "transparent",
			},
			on_highlights = function() end,
			on_colors = function() end,
		})

		vim.cmd("colorscheme tokyonight")

		-- transparency
		local colors = require("tokyonight.colors").setup()
		-- general
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalDark", { bg = "none" })
		-- lazy
		vim.api.nvim_set_hl(0, "LazyNormal", { bg = "none" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = colors.blue })
		-- telescope
		-- vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" }) -- replaced by on_highlights
		-- vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none", fg = colors.blue }) -- replaced by on_highlights
		-- vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "none" })
		-- vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "none" })
	end,
}
