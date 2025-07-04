return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
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

        local function mode_bg() return { bg = mode_color[vim.fn.mode()], fg = colors.bg } end

        local mode = {
            'mode',
            separator = { left = '', right = '' },
            right_padding = 2,
            color = mode_bg,
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
            update_in_insert = false,
        }

        local active_lsp = {
            function()
                local msg = 'No Active Lsp'

                local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                local bufnr = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = bufnr })

                if next(clients) == nil then return msg end

                for _, client in pairs(clients) do
                    local filetypes = client.config.filetypes or {}
                    if vim.tbl_contains(filetypes, buf_ft) then return client.name end
                end

                return msg
            end,
            icon = '⚙️',
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

        local buffers = {
            'buffers',
            icons_enabled = false,
            max_length = math.floor(vim.o.columns * 0.5),
            symbols = { modified = '●', alternate_file = '' },
        }

        local virtual_env = function()
            if vim.bo.filetype ~= 'python' then return '' end
            local conda, venv = os.getenv('CONDA_DEFAULT_ENV'), os.getenv('VIRTUAL_ENV')
            if venv then return ' ' .. vim.fn.fnamemodify(venv, ':t') end
            if conda then return '  ' .. conda .. ' (conda)' end
            return ''
        end

        -- local virtual_env = function()
        --     if vim.bo.filetype ~= 'python' then return '' end
        --
        --     local conda_env = os.getenv('CONDA_DEFAULT_ENV')
        --     local venv_path = os.getenv('VIRTUAL_ENV')
        --
        --     if venv_path == nil then
        --         if conda_env == nil then
        --             return ''
        --         else
        --             return string.format('  %s (conda)', conda_env)
        --         end
        --     else
        --         local venv_name = vim.fn.fnamemodify(venv_path, ':t')
        --         return string.format(' %s', venv_name)
        --     end
        -- end

        local location = {
            'location',
            separator = { left = '', right = '' },
            left_padding = 2,
            color = mode_bg,
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
                        c = { bg = 'None', gui = 'bold', fg = '#FFFFFF' },
                        x = { bg = 'None', gui = 'bold' },
                        y = { bg = 'None', gui = 'bold' },
                        z = { bg = 'None', gui = 'bold' },
                    },
                    visual = {
                        a = { bg = 'None', gui = 'bold' },
                        b = { bg = 'None', gui = 'bold' },
                        c = { bg = 'None', gui = 'bold', fg = '#FFFFFF' },
                        x = { bg = 'None', gui = 'bold' },
                        y = { bg = 'None', gui = 'bold' },
                        z = { bg = 'None', gui = 'bold' },
                    },
                    replace = {
                        a = { bg = 'None', gui = 'bold' },
                        b = { bg = 'None', gui = 'bold' },
                        c = { bg = 'None', gui = 'bold', fg = '#FFFFFF' },
                        x = { bg = 'None', gui = 'bold' },
                        y = { bg = 'None', gui = 'bold' },
                        z = { bg = 'None', gui = 'bold' },
                    },
                    inactive = {
                        a = { bg = 'None', gui = 'bold' },
                        b = { bg = 'None', gui = 'bold' },
                        c = { bg = 'None', gui = 'bold', fg = '#ababab' },
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
                lualine_x = { active_lsp, virtual_env },
                lualine_y = { diagnostics },
                lualine_z = { location },
            },
        })
    end,
}
