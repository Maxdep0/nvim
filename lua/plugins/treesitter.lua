-- Windows: https://github.com/niXman/mingw-builds-binaries
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    config = function()
        require('nvim-treesitter.install').prefer_git = true

        require('nvim-treesitter.configs').setup({
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
            auto_install = true,

            ensure_installed = {
                'css',
                'scss',
                'html',
                'json',
                'lua',
                'luadoc',
                'vim',
                'vimdoc',
                'javascript',
                'typescript',
                'markdown',
                'gitignore',
                'python',
                'toml',
            },
        })
    end,
}
