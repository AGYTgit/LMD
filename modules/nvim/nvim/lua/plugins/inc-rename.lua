local modName = "[Inc-rename] "

return {
	"smjonas/inc-rename.nvim",
	config = function() require("inc_rename").setup({}) end,
	keys = {
		{ "<leader>rn", function() return ":IncRename " .. vim.fn.expand("<cword>") end, mode = "n", expr = true, desc = modName .. "Rename variable" },
	},
}
