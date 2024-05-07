return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    cond = true,

    config = function()
        local config = require('nvim-treesitter.configs')
        config.setup({
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
                'vim',
                'vimdoc',
                'javascript',
                'typescript',
                'markdown',
                'gitignore',
            },
        })
    end,
}
