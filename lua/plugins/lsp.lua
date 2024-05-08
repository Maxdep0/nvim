return {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    cond = true,

    config = function()
        local lspconfig = require('lspconfig')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        local builtin = require('telescope.builtin')

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

        local on_attach = function(client, bufnr)
            local map = function(keys, func, desc)
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            map('gd', builtin.lsp_definitions, '[G]o to [D]efintion')
            map('gr', builtin.lsp_references, '[G]o to [R]eferences')
            map('gI', builtin.lsp_implementations, '[G]o to, [I]mplementation')
            map('<leader>D', builtin.lsp_type_definitions, 'Type [D]efinitions')
            map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
            map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[D]ocument [S]ymbols')
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
            map('K', vim.lsp.buf.hover, 'Hover Documentation')
            map('[d', vim.diagnostic.goto_prev, 'Go to previous diagnostics')
            map(']d', vim.diagnostic.goto_prev, 'Go to next diagnostics')
            map('gD', vim.lsp.buf.declaration, '[G]o to [D]eclaration')
            map('<C-h>', vim.lsp.buf.signature_help, 'Get signature help')
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
