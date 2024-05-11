return {
    'nvim-lualine/lualine.nvim',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
        local cbg = require('lualine.themes.onedark')

        cbg.normal.b.bg = '#2d353b'
        cbg.normal.c.bg = '#2d353b'
        cbg.inactive.b.bg = '#2d353b'
        cbg.inactive.c.bg = '#2d353b'

        require('lualine').setup({
            options = {
                icons_enabled = false,
                theme = cbg,
                component_separators = ' ',
                section_separators = '  ',
                always_divide_middle = true,
            },
            sections = {

                lualine_a = { 'mode' },
                lualine_b = {
                    {
                        'diagnostics',
                        sources = { 'nvim_diagnostic' },

                        sections = { 'error', 'warn', 'info', 'hint' },

                        symbols = { error = '', warn = '', info = '', hint = '' },

                        diagnostics_color = {
                            error = { fg = '#F44336' },
                            warn = { fg = '#FFEB3B' },
                            info = { fg = '#2196F3' },
                            hint = { fg = '#4CAF50' },
                        },
                    },
                },

                lualine_c = {
                    function()
                        return '%='
                    end,
                    {
                        'buffers',
                    },
                },
                lualine_x = {
                    {
                        function()
                            local msg = 'No Active Lsp'
                            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                            local clients = vim.lsp.get_active_clients()
                            if next(clients) == nil then
                                return msg
                            end
                            for _, client in ipairs(clients) do
                                local filetypes = client.config.filetypes
                                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                    return client.name
                                end
                            end
                            return msg
                        end,
                        icon = 'LSP:',
                        color = { fg = '#c4c4c4', gui = 'bold' },
                    },
                },
                lualine_y = {
                    {
                        function()
                            local linters = require('lint').get_running()
                            if #linters == 0 then
                                return '󰦕'
                            end
                            return '󱉶 ' .. table.concat(linters, ', ')
                        end,
                    },
                    {
                        'branch',
                    },
                },
                lualine_z = {
                    {
                        'datetime',
                        style = '%H:%M',
                    },
                },
            },
        })
    end,
}
