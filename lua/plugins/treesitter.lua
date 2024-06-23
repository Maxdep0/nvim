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
            rainbow = { enable = false },
            textobject = { enable = false },
            playground = { enable = false },

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
                'markdown',
                'bash',
            },
        })
    end,
}
