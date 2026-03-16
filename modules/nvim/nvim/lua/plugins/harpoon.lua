local modName = "[Harpoon] "

return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon.setup()

		local harpoon_extensions = require("harpoon.extensions")
		harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
	end,

	keys = {
		{ "<leader>th", function() require("telescope").extensions.harpoon.marks({ prompt_title = "Harpoon" }) end, mode = "n", desc = modName .. "[Telescope] Harpoon marks" },
        { "<leader>hh", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, mode = "n", desc = modName .. "Harpoon menu" },
		{ "<leader>ha", function() require("harpoon"):list():add() end, mode = "n", desc = modName .. "Add buffer" },
        { "<leader>hd", function() require("harpoon"):list():remove() end, mode = "n", desc = modName .. "Remove from harpoon" },
		{ "<C-h>", function() require("harpoon"):list():select(1) end, mode = "n", desc = modName .. "Open buffer 1" },
		{ "<C-t>", function() require("harpoon"):list():select(2) end, mode = "n", desc = modName .. "Open buffer 2" },
		{ "<C-n>", function() require("harpoon"):list():select(3) end, mode = "n", desc = modName .. "Open buffer 3" },
		{ "<C-s>", function() require("harpoon"):list():select(4) end, mode = "n", desc = modName .. "Open buffer 4" },
		-- { "-", function() require("harpoon"):list():prev({ ui_nav_wrap = true }) end, mode = "n", desc = modName .. "Prev buffer" },
		-- { "+", function() require("harpoon"):list():next({ ui_nav_wrap = true }) end, mode = "n", desc = modName .. "Next buffer" },
	},
}
