return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'folke/neodev.nvim',
    },

    config = function()
        require('neodev').setup({})

        local lspconfig = require('lspconfig')
        local utils = require('core.utils')

        local on_attach = function(client, bufnr)
            local map = function(keys, func, desc)
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            if client.server_capabilities.signatureHelpProvider then
                map('<F3>', function()
                    utils.toggleSignatureHelp(bufnr)
                end, 'SPECIAL: Toggle Signature Help')
                utils.toggleSignatureHelp(bufnr)
            end
        end

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = 'rounded',
        })

        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = 'rounded',
            focusable = false,
            relative = 'cursor',
            anchor = 'SW',
            max_height = 5,
            -- row = -10,
            offset_y = -6,
        })

        -- vim.lsp.set_log_level('debug')

        vim.diagnostic.config({
            -- update_in_insert = true,
            update_in_insert = false,
            severity_sort = true,
            virtual_text = {
                source = false,
                prefix = '●',
            },

            float = {
                focusable = false,
                style = 'minimal',
                border = 'rounded',
                source = true,
                header = '',
                prefix = '',
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '● ',
                    [vim.diagnostic.severity.WARN] = '● ',
                    [vim.diagnostic.severity.INFO] = '● ',
                    [vim.diagnostic.severity.HINT] = '● ',
                },
            },
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local SELECT_SERVERS =
            { 'lua_ls', 'ts_ls', 'html', 'cssls', 'jsonls', 'emmet_language_server', 'pylsp', 'marksman', 'bashls' }

        for _, lsp in ipairs(SELECT_SERVERS) do
            local ok, opts = pcall(require, 'servers.' .. lsp)
            if ok then
                opts.on_attach = on_attach
                opts.capabilities = capabilities
                lspconfig[lsp].setup(opts)
            else
                print('Error for ' .. lsp .. ': ' .. opts)
            end
        end
    end,
}
