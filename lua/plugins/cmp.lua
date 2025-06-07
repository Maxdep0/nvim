return {
    'saghen/blink.cmp',
    -- dependencies = { 'rafamadriz/friendly-snippets' },
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
        keymap = { preset = 'default' },

        appearance = {
            nerd_font_variant = 'mono',
        },

        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            ghost_text = { enabled = true },
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

        fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    opts_extend = { 'sources.default' },
}
