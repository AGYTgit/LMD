return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				results_title = false,
				preview_title = "Preview",
				prompt_prefix = " ",
				selection_caret = " ",
				sorting_strategy = "ascending",
				layout_strategy = "flex",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						preview_cutoff = 0,
					},
					vertical = {
						prompt_position = "top",
						preview_cutoff = 0,
						mirror = true,
					},
					flex = {
						flip_columns = 120,
					},
					width = 0.87,
					height = 0.80,
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<esc>"] = actions.close,
					},
				},
				borderchars = {
					prompt = { "─", "│", "─", "│", "╭", "╮", "│", "│" },
					results = { " ", "│", "─", "│", "│", "│", "╯", "╰" },
					preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				},
			},
			pickers = {
				find_files = {
			        prompt_title = "Files",
					results_title = "-----   -----   -----   -----   -----",
                    entry_maker = function(entry)
                        local make_entry = require("telescope.make_entry")
                        local default = make_entry.gen_from_file({})(entry)
                        local dir = entry:match("(.+)/[^/]+$") or ""
                        local file = entry:match("[^/]+$") or entry

                        default.display = function(e)
                            local icon, icon_hl = require("nvim-web-devicons").get_icon(file, nil, { default = true })
                            local path = (dir ~= "" and dir .. "/" or "")
                            local text = icon .. " " .. path .. file
                            local icon_byte_len = #icon + 1
                            return text, {
                                { { 0, icon_byte_len }, icon_hl },
                                { { icon_byte_len, icon_byte_len + #path }, "TelescopeResultsComment" },
                                { { icon_byte_len + #path, #text }, "TelescopeResultsFile" },
                            }
                        end
                    return default
                end,
				},
				live_grep = {
					prompt_title = "Grep",
				},
				keymaps = {
					prompt_title = "Binds",
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("projects")

		local colors = require("tokyonight.colors").setup()

		vim.api.nvim_set_hl(0, "TelescopeTitle", { fg = colors.orange })
		vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = colors.blue })
		vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = colors.blue })
		vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { fg = colors.blue })
		vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { fg = colors.blue })

        vim.api.nvim_set_hl(0, "TelescopeResultsComment", { fg = colors.comment })
        vim.api.nvim_set_hl(0, "TelescopeResultsFile", { fg = colors.fg })
	end,
}
