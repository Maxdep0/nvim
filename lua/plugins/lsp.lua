return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'folke/neodev.nvim',
    },

    config = function()
        require('neodev').setup({})

        local lspconfig = require('lspconfig')
        local builtin = require('telescope.builtin')

        local on_attach = function(client, bufnr)
            local map = function(keys, func, desc)
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
            end

            map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
            map('gr', builtin.lsp_references, '[G]oto [R]eferences')
            map('gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
            map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinition')
            map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
            map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
            map('K', vim.lsp.buf.hover, 'Hover Documentation')
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
            map('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
            map(']d', vim.diagnostic.goto_prev, 'Go to next diagnostic')
            map('<C-h>', vim.lsp.buf.signature_help, 'Get signature help')

            if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                map('<leader>th', function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, '[T]oggle Inlay [H]ints')
            end

            if client.server_capabilities.documentHighlightProvider then
                vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
                vim.api.nvim_clear_autocmds({ buffer = bufnr, group = 'lsp_document_highlight' })
                vim.api.nvim_create_autocmd('CursorHold', {
                    callback = vim.lsp.buf.document_highlight,
                    buffer = bufnr,
                    group = 'lsp_document_highlight',
                    desc = 'Document Highlight',
                })
                vim.api.nvim_create_autocmd('CursorMoved', {
                    callback = vim.lsp.buf.clear_references,
                    buffer = bufnr,
                    group = 'lsp_document_highlight',
                    desc = 'Clear All the References',
                })
            end
        end

        local signs = { Error = '● ', Warn = '● ', Hint = '● ', Info = '● ' }
        for type, icon in pairs(signs) do
            local hl = 'DiagnosticSign' .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = 'rounded',
        })

        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = 'rounded',
        })

        vim.diagnostic.config({
            update_in_insert = true,
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
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        local SELECT_SERVERS = { 'lua_ls', 'tsserver', 'html', 'cssls', 'jsonls', 'emmet_language_server' }

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
