return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"ahmedkhalf/project.nvim",
	},
	config = function()
		local colors = require("tokyonight.colors").setup()

		require("lualine").setup({
			options = {
				theme = "tokyonight",
				icons_enabled = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {
					"branch",
				},
				lualine_c = {
					{
						function()
							local root = require("project_nvim.project").get_project_root()
							local rel = vim.fn.expand("%:p"):sub(#root + 2)
							return "󱉭  " .. (rel:match("([^/]+)") or "")
						end,
						color = { fg = colors.comment },
					},
					{ "filetype", icon_only = true, separator = { right = "" }, padding = { left = 1, right = 0 } },

					{
						function()
							local parts = vim.fn.expand("%:~:."):match("(.+)/[^/]+$") or ""
							return parts ~= "" and parts .. "/" or ""
						end,
						color = { fg = colors.fg_dark },
						padding = { left = 1, right = 0 },
						separator = { right = "" },
					},
					{
						function()
							return vim.fn.expand("%:t")
						end,
						color = { fg = colors.fg },
						padding = { left = 0, right = 1 },
					},
				},
				lualine_x = {},
				lualine_y = { { "diff", symbols = { added = " ", modified = " ", removed = " " } } },
				lualine_z = { "location" },
			},
		})
	end,
}
