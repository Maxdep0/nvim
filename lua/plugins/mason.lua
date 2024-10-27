return {
    'williamboman/mason.nvim',
    dependencies = {
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer',
    },

    config = function()
        require('mason').setup({
            ui = {
                border = 'rounded',
                width = 0.5,
            },
        })

        require('mason-lspconfig').setup({
            ensure_installed = {
                'ts_ls',
                'html',
                'cssls',
                'jsonls',
                'lua_ls',
                'emmet_language_server',
                -- 'pyright',
                'pylsp',
                'marksman',
                'bashls',
            },
            automatic_installation = true,
        })

        require('mason-tool-installer').setup({
            ensure_installed = {
                'prettierd',
                'eslint_d',
                'stylua',
                'selene',
                'flake8',
                -- 'black',
                -- 'autopep8',
                'shellcheck',
                'shfmt',
            },
        })
    end,
}
