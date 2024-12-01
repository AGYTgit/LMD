require('nvim-tree').setup({
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    filters = {
        dotfiles = true,
    },
    view = {
        width = 35,
        number = true,
        relativenumber = true,
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
        icons = { glyphs = { folder = {
            arrow_closed = "",
            arrow_open = "",
        }}},
    },
    actions = { open_file = {
        window_picker = {
            enable = false,
        },
        quit_on_open = true,
    }},
    git = {
        enable = true,
        ignore = true,
    },
})

local k = vim.keymap

k.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
