require('telescope').setup({
    defaults = {
        path_display = { 'smart' },
        mappings = {
            i = {
                ['<C-k>'] = require('telescope.actions').move_selection_previous,
                ['<C-j>'] = require('telescope.actions').move_selection_next,
            },
        },
        file_ignore_patterns = { ".git/" },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
    sorting_strategy = "ascending",
    color_devicons = true,
})

require('telescope').load_extension('fzf')
