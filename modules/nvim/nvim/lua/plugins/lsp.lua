return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"rust_analyzer",
					"clangd",
					"jdtls",
					"taplo",
					"lua_ls",
					-- "bashls",  -- ERROR: mason fails to install these
					-- "yamlls",
					-- "jsonls",
					-- "dockerls",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim", "folke/lazydev.nvim" },
		config = function()
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
					},
				},
			})

			vim.lsp.config("rust_analyzer", {})
			vim.lsp.config("clangd", {})
			vim.lsp.config("jdtls", {})
			vim.lsp.config("bashls", {})
			vim.lsp.config("yamlls", {})
			vim.lsp.config("taplo", {})
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						diagnostics = {
							globals = { "vim", "Snacks" },
						},
					},
				},
			})
			vim.lsp.config("jsonls", {})
			vim.lsp.config("dockerls", {})

			vim.lsp.enable({
				"rust_analyzer",
				"clangd",
				"jdtls",
				"bashls",
				"yamlls",
				"taplo",
				"lua_ls",
				"jsonls",
				"dockerls",
			})
		end,
	},
}
