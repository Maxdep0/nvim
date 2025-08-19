return {
    'saghen/blink.cmp',
    version = '1.*',
    event = { 'InsertEnter', 'CmdLineEnter' },
    dependencies = {
        {
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = { library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } } },
        },
        {
            'zbirenbaum/copilot.lua',
            cmd = 'Copilot',
            event = 'InsertEnter',
            dependencies = { 'fang2hou/blink-copilot' },

            config = function() require('copilot').setup({}) end,
        },
    },
    opts = {
        keymap = {
            preset = 'none',

            ['<C-k>'] = { 'select_prev' },
            ['<C-j>'] = { 'select_next' },

            ['<C-u>'] = { 'scroll_documentation_up' },
            ['<C-d>'] = { 'scroll_documentation_down' },

            ['<C-e>'] = { 'hide' },
            ['<C-space>'] = { 'show' },

            ['<Tab>'] = { 'snippet_forward', 'fallback' },
            ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

            ['<C-l>'] = { 'accept', 'fallback' },

            ['<F3>'] = { 'show_signature', 'hide_signature' },
        },

        term = { enabled = true },

        cmdline = {
            keymap = { preset = 'inherit' },

            completion = {
                menu = { auto_show = true },
                list = { selection = { preselect = false } },
            },
        },

        -- appearance = { nerd_font_variant = 'mono' },
        appearance = {
            kind_icons = {
                Copilot = '',
                Text = '󰉿',
                Method = '󰊕',
                Function = '󰊕',
                Constructor = '󰒓',

                Field = '󰜢',
                Variable = '󰆦',
                Property = '󰖷',
                Class = '󱡠',
                Interface = '󱡠',
                Struct = '󱡠',
                Module = '󰅩',
                Unit = '󰪚',
                Value = '󰦨',
                Enum = '󰦨',
                EnumMember = '󰦨',
                Keyword = '󰻾',
                Constant = '󰏿',
                Snippet = '󱄽',
                Color = '󰏘',
                File = '󰈔',
                Reference = '󰬲',
                Folder = '󰉋',
                Event = '󱐋',
                Operator = '󰪚',
                TypeParameter = '󰬛',
            },
        },

        completion = {
            menu = { draw = { padding = { 1, 1 } } },

            list = {
                selection = {
                    preselect = true,
                    auto_insert = true,
                },
            },

            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,

                window = { border = 'single' },
            },

            ghost_text = { enabled = false },
        },

        sources = {
            default = { 'path', 'lsp', 'buffer', 'copilot', 'lazydev', 'snippets', 'omni', 'cmdline' },

            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                },
                copilot = {
                    name = 'copilot',
                    module = 'blink-copilot',
                    async = true,
                    opts = {
                        max_completions = 3,
                    },
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
