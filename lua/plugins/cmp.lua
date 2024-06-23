return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        {
            'L3MON4D3/LuaSnip',
            dependencies = {
                'saadparwaiz1/cmp_luasnip',
                -- 'rafamadriz/friendly-snippets',
            },
        },
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-nvim-lua',
        'onsails/lspkind.nvim',
        { 'zbirenbaum/copilot-cmp', event = 'LspAttach' },
    },
    event = { 'InsertEnter', 'CmdlineEnter' },

    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')
        require('copilot_cmp').setup()

        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_vscode').load({ paths = './snippets' })

        cmp.setup({
            completion = { completeopt = 'menu,menuone,noinsert' },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
                    local kind = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 100,
                        show_labelDetails = true,
                        ellipsis_char = '...',
                        symbol_map = { Copilot = '' },
                    })(entry, vim_item)
                    local strings = vim.split(kind.kind, '%s', { trimempty = true })
                    kind.kind = ' ' .. (strings[1] or '') .. ' '
                    kind.menu = '    (' .. (strings[2] or '') .. ')'

                    return kind
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),

                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-l>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ['<C-h>'] = cmp.mapping.scroll_docs(4),

                ['<C-e>'] = cmp.mapping.abort(),

                -- ['<CR>'] = cmp.mapping.confirm({ select = true }),

                ['<CR>'] = cmp.mapping({
                    i = function(fallback)
                        if cmp.visible() and cmp.get_active_entry() then
                            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                        else
                            fallback()
                        end
                    end,
                    s = cmp.mapping.confirm({ select = true }),
                    -- c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                }),

                ['<C-Space>'] = cmp.mapping.complete(),

                ['<Tab>'] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    elseif cmp.visible() then
                        cmp.confirm({ select = true })
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),

            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            sources = {
                { name = 'copilot', keyword_length = 0, max_item_count = 5 },
                { name = 'nvim_lsp', max_item_count = 20 },
                { name = 'nvim_lua', keyword_length = 2, max_item_count = 10 },
                { name = 'luasnip', keyword_length = 2, max_item_count = 8 },
                { name = 'buffer', keyword_length = 2, max_item_count = 5 },
                { name = 'path', max_item_count = 4 },
            },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            view = { entries = 'custom' },

            experimental = { ghost_text = false },

            sorting = {
                priority_weight = 2,
                comparators = {
                    require('copilot_cmp.comparators').prioritize,
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
        })

        cmp.setup.cmdline({ '/' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer', max_item_count = 5 },
            },
        })

        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path', max_item_count = 3 },
            }, {
                { name = 'cmdline', max_item_count = 6 },
            }),
        })
    end,
}
