--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]


return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use({"nvim-tree/nvim-web-devicons"})
    use({"MunifTanjim/nui.nvim",})
    use({"3rd/image.nvim"})
    use({
        "stevearc/oil.nvim",
    })

    use({'shaunsingh/nord.nvim', as = 'nord'})
    vim.cmd[[colorscheme nord]]

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }


    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('ThePrimeagen/harpoon')

    --use {
    --    'VonHeikemen/lsp-zero.nvim',
    --    branch = 'v3.x',
    --    requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
    use('williamboman/mason.nvim')
    use('williamboman/mason-lspconfig.nvim')

    -- LSP Support
    use('neovim/nvim-lspconfig')
    -- Autocompletion
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-nvim-lsp')
    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')
    use('rafamadriz/friendly-snippets')
    --    }
    --}

    --use {
    --    'antosha417/nvim-lsp-file-operations',
    --    requires = {
    --        'nvim-lua/plenary.nvim',
    --        'nvim-neo-tree/neo-tree.nvim',
    --    }
    --}

    use('stevearc/dressing.nvim')
end)

