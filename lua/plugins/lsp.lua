return {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    cond = true,

    config = function()
        local lspconfig = require('lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

        local on_attach = function(client, bufnr)
            --    if client.server_capabilities.documentHighlightProvider then
            --     vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
            --     vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
            --     vim.api.nvim_create_autocmd("CursorHold", {
            --         callback = vim.lsp.buf.document_highlight,
            --         buffer = bufnr,
            --         group = "lsp_document_highlight",
            --         desc = "Document Highlight",
            --     })
            --     vim.api.nvim_create_autocmd("CursorMoved", {
            --         callback = vim.lsp.buf.clear_references,
            --         buffer = bufnr,
            --         group = "lsp_document_highlight",
            --         desc = "Clear All the References",
            --     })
            -- end

            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
            vim.keymap.set('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
            vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
            -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, bufopts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
        end

        vim.api.nvim_create_autocmd('CursorHold', {
            desc = 'Open float on hover',
            callback = function()
                vim.diagnostic.open_float(nil, { focus = false })
            end,
        })

        local signs = { Error = '● ', Warn = '● ', Hint = '● ', Info = '● ' }
        for type, icon in pairs(signs) do
            local hl = 'DiagnosticSign' .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

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
                source = 'always',
                header = '',
                prefix = '',
            },
        })

        lspconfig.tsserver.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            },
        })

        lspconfig.lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    completion = {
                        enable = true,
                        callSnippet = 'Replace',
                        displayContext = 5,
                        keywordSnippet = 'Replace',
                        postfix = '@',
                        requireSeparator = '.',
                        showParams = true,
                        showWord = 'Fallback',
                        workspaceWord = true,
                    },
                    semantic = {
                        enable = true,
                        keyword = false,
                    },
                    hint = { enable = true },
                    hover = { enable = true },
                    signatureHelp = { enable = true },

                    diagnostics = { enable = false },
                    format = { enable = false },
                    -- telemetry = { enable = false },
                },
            },
        })
    end,
}
