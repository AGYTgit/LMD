local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if not vim.loop.fs_stat(install_path) then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
vim.cmd('packadd packer.nvim')

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use { 'Mofiqul/vscode.nvim',
        config = function()
            require('plugins.colorscheme')
        end
    }
    use { 'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require('plugins.nvim-tree')
        end
    }
end)
