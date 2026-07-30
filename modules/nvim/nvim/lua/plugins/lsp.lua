local modName = "[Lsp] "

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                }
            })
        end,
        keys = {
            { "<leader>ca", vim.lsp.buf.code_action, mode = "n", desc = modName .. "Code actions" },
            { "<leader>m", "<cmd>Mason<cr>", mode = "n", desc = modName .. "Mason" },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "clangd",
                    "jdtls",
                    "bashls",
                    "yamlls",
                    "taplo",
                    "jsonls",
                    "dockerls",
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
                            library = {
                                "/usr/share/hypr/stubs",
                                "/usr/share/hyprland/stubs",
                            },
                        },
                        diagnostics = {
                            globals = { "vim", "Snacks", "hl" },
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
