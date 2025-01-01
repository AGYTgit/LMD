require('vscode').setup({
    transparent = true,
    styles = {
        sidebars = 'transparent',
        floats = 'transparent',
    },
    italic_comments = true,
    disable_nvimtree_bg = true,
    color_overrides = {
        vscLineNumber = '#646464',
    },
})
vim.cmd('colorscheme vscode')
vim.cmd('highlight EndOfBuffer guifg=#646464')
