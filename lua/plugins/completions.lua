return {
    'hrsh7th/nvim-cmp', -- Autocompletion plugin
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'onsails/lspkind.nvim',
        'L3MON4D3/LuaSnip', -- Snippet Engine
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lua',
        'rafamadriz/friendly-snippets',
    },
    event = 'InsertEnter',
    cond = true,

    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')

        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_vscode').load({ paths = './snippets' })

        cmp.setup({
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    local kind = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 100,
                        show_labelDetails = true,
                        ellipsis_char = '...',
                    })(entry, vim_item)
                    local strings = vim.split(kind.kind, '%s', { trimempty = true })
                    kind.kind = ' ' .. (strings[1] or '') .. ' '
                    kind.menu = '    (' .. (strings[2] or '') .. ')'

                    return kind
                end,
            },
            completion = {
                completeopt = 'menu,menuone,preview,noselect',
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            cmp.config.window.bordered(),

            view = { entries = 'custom' },

            experimental = {
                ghost_text = true,
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-u>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                -- ['<CR>'] = cmp.mapping.confirm({ select = true }

                ['<CR>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        if luasnip.expandable() then
                            luasnip.expand()
                        else
                            cmp.confirm({ select = true })
                        end
                    else
                        fallback()
                    end
                end),

                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.locally_jumpable(1) then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),

            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'path' },
            }),
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                { name = 'cmdline' },
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
        })
    end,
}
