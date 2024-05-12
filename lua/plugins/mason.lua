-- https://chocolatey.org/install   --  gzip, unzip, wget

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
                'tsserver',
                'html',
                'cssls',
                'jsonls',
                'lua_ls',
                'emmet_language_server',
            },
            automatic_installation = true,
        })

        require('mason-tool-installer').setup({
            ensure_installed = {
                'prettierd',
                'eslint_d',
                'stylua',
                'selene',
            },
        })
    end,
}
