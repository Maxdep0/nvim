return {
    'williamboman/mason.nvim',
    dependencies = {
        'WhoIsSethDaniel/mason-tool-installer',
    },

    config = function()
        require('mason').setup({
            ui = {
                border = 'rounded',
                width = 0.5,
            },
        })

        require('mason-tool-installer').setup({
            ensure_installed = {
                -- LSP servers
                'typescript-language-server',
                'html-lsp',
                'emmet-language-server',
                'css-lsp',
                'json-lsp',
                'lua-language-server',
                'emmet-ls',
                'python-lsp-server',
                'bash-language-server',
                'pyright',
                'rust-analyzer',

                -- Formatters
                'prettierd',
                'stylua',
                'black',
                'shfmt',

                -- Linters
                'eslint_d',
                'selene',
                'flake8',
                'shellcheck',
                'stylelint',
                'htmlhint',
            },
        })
    end,
}
