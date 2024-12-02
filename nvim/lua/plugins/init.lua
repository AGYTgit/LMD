local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if not vim.fn.isdirectory(install_path) then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd('packadd packer.nvim')

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use { 'Mofiqul/vscode.nvim',
        config = function() require('plugins.colorscheme') end
    }
    use { 'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = function() require('plugins.nvim-tree') end
    }
    use { "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        requires = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-tree/nvim-web-devicons",
            "folke/todo-comments.nvim",
        },
        config = function() require("plugins.telescope") end
    }
    use { 'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require('plugins.treesitter') end
    }
    use {
      'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true },
        config = function() require('plugins.lualine') end
    }
    use { 'neovim/nvim-lspconfig' ,
        config = function() require('plugins.lspconfig') end
    }
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
end)
