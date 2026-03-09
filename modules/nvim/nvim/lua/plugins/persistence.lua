local modName = "[Persistance] "

return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	config = function() require("persistence").setup({}) end,
	keys = function()
		local p = require("persistence")
		return {
			{ "<leader>qs", function() p.load() end, desc = modName .. "Restore session" },
			-- { "<leader>ql", function() p.load({ last = true }) end, desc = modName .. "Restore last session" },
			-- { "<leader>qd", function() p.stop() end, desc = modName .. "Don't save session" },
		}
	end,
}
