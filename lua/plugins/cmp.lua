return {
    'saghen/blink.cmp',
    dependencies = {
        {
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
        },
    },
    version = '1.*',
    event = { 'InsertEnter', 'CmdLineEnter' },
    opts = {
        keymap = {
            preset = 'none',

            ['<C-k>'] = { 'select_prev' },
            ['<C-j>'] = { 'select_next' },

            ['<C-u>'] = { 'scroll_documentation_up' },
            ['<C-d>'] = { 'scroll_documentation_down' },

            ['<C-e>'] = { 'hide' },

            ['<Tab>'] = { 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

            ['<C-l>'] = { 'accept', 'fallback' },

            ['<F3>'] = { 'show_signature', 'hide_signature' },
        },

        cmdline = {
            keymap = { preset = 'inherit' },

            completion = {
                menu = {
                    auto_show = true,
                },
            },
        },

        appearance = {
            nerd_font_variant = 'mono',
        },

        completion = {
            menu = {
                draw = {
                    padding = { 1, 1 },
                },
            },

            list = {
                selection = {
                    preselect = false,
                    auto_insert = true,
                },
            },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,

                window = {
                    border = 'single',
                },
            },

            ghost_text = { enabled = false },
        },

        sources = {
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },

            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    score_offset = 100,
                },
            },
        },

        signature = {
            enabled = true,
            window = {
                min_width = 1,
                max_width = 100,
                max_height = 10,
                border = 'single',
                winblend = 100,
            },
        },

        fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
}
