return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = { 'InsertEnter', 'LspAttach' },

    config = function()
        -- vim.api.nvim_set_hl(0, 'CopilotSuggestion', { fg = '#f5c2e7' })
        vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })

        require('copilot').setup({
            panel = { enabled = false, auto_refresh = false },
            suggestion = {
                enabled = false,
                auto_trigger = true,
                debounce = 75,
                keymap = { accept_word = false, accept_line = false },
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
