require('nvim-treesitter.configs').setup {
    ensure_installed = { "cpp", "c", "scss", "yuck", "lua" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
    },
    modules = {},
    sync_install = false,
    ignore_install = {},
    auto_install = true,
}
