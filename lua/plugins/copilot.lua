return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
        vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = '#f5c2e7' })
        vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })

        require('copilot').setup({
            panel = {
                enabled = false,
                auto_refresh = false,
                -- keymap = {
                --     jump_prev = '[[',
                --     jump_next = ']]',
                --     accept = '<F6>',
                --     refresh = 'gr',
                --     open = '<F7>',
                -- },
                -- layout = {
                --     position = 'bottom', -- | top | left | right
                --     ratio = 0.4,
                -- },
            },
            suggestion = {
                enabled = false,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    -- accept = '<F7>',
                    accept_word = false,
                    accept_line = false,
                    -- next = '<C-n>',
                    -- prev = '<C-p>',
                    -- dismiss = '<F8>',
                },
            },
            filetypes = {
                javascript = true,
                typescript = true,
                lua = true,
                ['.'] = false,
            },
            copilot_node_command = 'node', -- Node.js version must be > 18.x
            server_opts_overrides = {},
        })
    end,
}
