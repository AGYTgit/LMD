local modName = "[Telescope] "

local function dir_grep(opts)
    opts = opts or {}
    local additional_args = opts.additional_args or {}
    local prompt_title = opts.prompt_title or "Grep"
	local finders = require("telescope.finders")
	local pickers = require("telescope.pickers")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local state = require("telescope.actions.state")

	local dirs = { "." }
	local handle = io.popen("fd --type d --strip-cwd-prefix --no-ignore --hidden")
	if handle then
		for line in handle:lines() do
			table.insert(dirs, line)
		end
		handle:close()
	end

	pickers.new({}, {
		prompt_title = "Select Directory",
		finder = finders.new_table({ results = dirs }),
		sorter = conf.generic_sorter({}),
        previewer = conf.file_previewer({}),
		attach_mappings = function(prompt_bufnr)
			actions.select_default:replace(function()
				local dir = state.get_selected_entry()[1]
				actions.close(prompt_bufnr)
				require("telescope.builtin").live_grep({
                    prompt_title = prompt_title,
					search_dirs = { dir },
					additional_args = additional_args,
				})
			end)
			return true
		end,
	}):find()
end

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
                    find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--no-ignore", "--hidden" },
					prompt_title = "Files",
					results_title = "",
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
					initial_sort = "description",
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

	keys = {
		{ "<leader>tt", "<cmd>Telescope find_files<CR>", mode = "n", desc = modName .. "Find files" },
		-- { "<leader>tg", "<cmd>Telescope live_grep<CR>", mode = "n", desc = modName .. "Live grep" },
		{ "<leader>tn", "<cmd>TodoTelescope<cr>", mode = "n", desc = modName .. "Find todo" },
		{ "<leader>?", "<cmd>Telescope keymaps<CR>", mode = "n", desc = modName .. "Show keymaps" },
		{ "<leader>tg", function() dir_grep({ additional_args = { "--no-ignore", "--hidden" } }) end, mode = "n", desc = modName .. "Grep in directory" },
		{ "<leader>tG", function() dir_grep({ additional_args = { "--no-ignore", "--hidden", "--files-without-match" }, prompt_title = "IGrep" }) end, mode = "n", desc = modName .. "Grep missing in directory" },
	},
}
