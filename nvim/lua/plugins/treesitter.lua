require('nvim-treesitter.configs').setup {
    ensure_installed = { "cpp", "c", "scss", "yuck" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
