require('lualine').setup({
  options = {
    theme = 'vscode',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    icons_enabled = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {{
      'branch',
      'diff', -- diff and diagnostics not showing (someting with lspconfig?)
      'diagnostics',
      colored = true,
      diff_color = {
        added    = { fg = '#A3BE8C' },
        modified = { fg = '#EBCB8B' },
        removed  = { fg = '#BF616A' },
      },
      symbols = { added = '+', modified = '~', removed = '-' }
    }},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
})
