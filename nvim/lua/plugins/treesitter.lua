require'nvim-treesitter.configs'.setup {
    ensure_installed = { "cpp", "csharp" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
