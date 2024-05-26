return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    -- cond = false,
    config = function()
        local lualine = require('lualine')
        local colors = {
            bg = '#1e1e2e',
            fg = '#cdd6f4',
            yellow = '#f9e2af',
            cyan = '#89dceb',
            darkblue = '#89b4fa',
            green = '#a6e3a1',
            orange = '#fab387',
            violet = '#f5c2e7',
            magenta = '#cba6f7',
            blue = '#74c7ec',
            red = '#f38ba8',
        }

        local mode_color = {
            n = colors.red,
            i = colors.green,
            v = colors.blue,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.magenta,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }

        local mode = {
            'mode',
            separator = { left = '', right = '' },
            right_padding = 2,
            color = function()
                return { bg = mode_color[vim.fn.mode()], fg = colors.bg }
            end,
        }
        local branch = {
            'branch',
            icon = '',
            color = { fg = colors.violet, bg = 'None', gui = 'bold' },
        }
        local diagnostics = {
            'diagnostics',
            sources = { 'nvim_diagnostic', 'nvim_lsp' },
            sections = { 'error', 'warn', 'info', 'hint' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            diagnostics_color = {
                color_error = { fg = colors.red, bg = 'None', gui = 'bold' },
                color_warn = { fg = colors.yellow, bg = 'None', gui = 'bold' },
                color_info = { fg = colors.cyan, bg = 'None', gui = 'bold' },
            },
            color = { bg = mode, gui = 'bold' },
            update_in_insert = false,
        }

        local activeLsp = {
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
            icon = '⚙️ ',
            color = { fg = '#c4c4c4', gui = 'bold' },
        }

        local diff = {
            'diff',
            symbols = { added = ' ', modified = ' ', removed = ' ' },
            diff_color = {
                added = { fg = colors.green, bg = 'None' },
                modified = { fg = colors.orange, bg = 'None' },
                removed = { fg = colors.red, bg = 'None' },
            },
        }

        local fileformat = {
            'fileformat',
            fmt = string.upper,
            color = { fg = colors.green, bg = 'None', gui = 'bold' },
        }

        local buffers = {
            'buffers',
            icons_enabled = false,
            max_length = vim.o.columns * 2 / 4,
            symbols = { modified = '●', alternate_file = '' },
        }

        local virtual_env = function()
            if vim.bo.filetype ~= 'python' then
                return ''
            end

            local conda_env = os.getenv('CONDA_DEFAULT_ENV')
            local venv_path = os.getenv('VIRTUAL_ENV')

            if venv_path == nil then
                if conda_env == nil then
                    return ''
                else
                    return string.format('  %s (conda)', conda_env)
                end
            else
                local venv_name = vim.fn.fnamemodify(venv_path, ':t')
                -- return string.format('  %s (venv)', venv_name)
                return string.format(' %s', venv_name)
            end
        end

        local location = {
            'location',
            separator = { left = '', right = '' },
            left_padding = 2,
            color = function()
                return { bg = mode_color[vim.fn.mode()], fg = colors.bg }
            end,
        }
        local sep = {
            '%=',
            color = { fg = colors.bg, bg = 'None' },
        }

        lualine.setup({
            options = {
                theme = {
                    normal = {
                        a = { bg = 'None', gui = 'bold' },
                        b = { bg = 'None', gui = 'bold' },
                        c = { bg = 'None', gui = 'bold', fg = '#FFFFFF' },
                        x = { bg = 'None', gui = 'bold' },
                        y = { bg = 'None', gui = 'bold' },
                        z = { bg = 'None', gui = 'bold' },
                    },
                    insert = {
                        a = { bg = 'None', gui = 'bold' },
                        b = { bg = 'None', gui = 'bold' },
                        c = { bg = 'None', gui = 'bold' },
                        x = { bg = 'None', gui = 'bold' },
                        y = { bg = 'None', gui = 'bold' },
                        z = { bg = 'None', gui = 'bold' },
                    },
                    visual = {
                        a = { bg = 'None', gui = 'bold' },
                        b = { bg = 'None', gui = 'bold' },
                        c = { bg = 'None', gui = 'bold' },
                        x = { bg = 'None', gui = 'bold' },
                        y = { bg = 'None', gui = 'bold' },
                        z = { bg = 'None', gui = 'bold' },
                    },
                    replace = {
                        a = { bg = 'None', gui = 'bold' },
                        b = { bg = 'None', gui = 'bold' },
                        c = { bg = 'None', gui = 'bold' },
                        x = { bg = 'None', gui = 'bold' },
                        y = { bg = 'None', gui = 'bold' },
                        z = { bg = 'None', gui = 'bold' },
                    },
                    command = {
                        a = { bg = 'None', gui = 'bold' },
                        b = { bg = 'None', gui = 'bold' },
                        c = { bg = 'None', gui = 'bold' },
                        x = { bg = 'None', gui = 'bold' },
                        y = { bg = 'None', gui = 'bold' },
                        z = { bg = 'None', gui = 'bold' },
                    },
                    inactive = {
                        a = { bg = 'None', gui = 'bold' },
                        b = { bg = 'None', gui = 'bold' },
                        c = { bg = 'None', fg = '#ababab' },
                        x = { bg = 'None', gui = 'bold' },
                        y = { bg = 'None', gui = 'bold' },
                        z = { bg = 'None', gui = 'bold' },
                    },
                },
                component_separators = '',
                section_separators = { left = '', right = '' },
                always_divide_middle = true,
            },
            sections = {
                lualine_a = { mode },
                lualine_b = { branch, diff },
                lualine_c = { sep, buffers },
                lualine_x = { activeLsp, virtual_env },
                lualine_y = { diagnostics }, --, fileformat },
                lualine_z = { location },
            },
            -- tabline = {
            --     lualine_a = {},
            --     lualine_b = {},
            --     lualine_c = {},
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = {},
            -- },
            -- winbar = {
            --     lualine_a = { sep },
            --     lualine_b = {},
            --     lualine_c = { sep, 'filename' },
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = { sep },
            -- },
            -- inactive_winbar = {
            --     lualine_a = { sep },
            --     lualine_b = {},
            --     lualine_c = { sep, 'filename' },
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = { sep },
            -- },
            -- extensions = { },
        })
    end,
}
