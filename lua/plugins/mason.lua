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

        require('mason-tool-installer').setup({
            ensure_installed = {
                'prettierd',
                'eslint_d',
                'stylua',
                'selene',
            },
        })
        require('mason-lspconfig').setup({
            ensure_installed = {
                'tsserver',
                'lua_ls',
            },
            automatic_installation = true,
        })
    end,
}
