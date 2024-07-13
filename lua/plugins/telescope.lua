-------------- stylua: ignore
return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',

            build = 'make',
        },
        {
            'nvim-tree/nvim-web-devicons',
            enabled = vim.g.have_nerd_font,
        },
    },
    config = function()
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        local action_layout = require('telescope.actions.layout')
        -- local TSLayout = require('telescope.pickers.layout')

        -- dropdown, cursor, ivy

        require('telescope').setup({
            defaults = {
                path_display = { 'smart' },

                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                        -- ['<C-n>'] = actions.cycle_history_next,
                        -- ['<C-p>'] = actions.cycle_history_prev,

                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        --
                        -- ['<C-c>'] = actions.close,
                        --
                        -- ['<Down>'] = actions.move_selection_next,
                        -- ['<Up>'] = actions.move_selection_previous,
                        --
                        ['<C-l>'] = actions.select_default,
                        -- ['<C-x>'] = actions.select_horizontal,
                        -- ['<C-v>'] = actions.select_vertical,
                        -- ['<C-t>'] = false, --actions.select_tab,
                        --
                        -- ['<C-u>'] = actions.preview_scrolling_up,
                        -- ['<C-d>'] = actions.preview_scrolling_down,
                        --
                        -- ['<PageUp>'] = actions.results_scrolling_up,
                        -- ['<PageDown>'] = actions.results_scrolling_down,
                        --
                        -- ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                        -- ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                        -- ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                        -- ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                        -- ['<C-l>'] = false,-- actions.complete_tag,
                        ['<C-_>'] = actions.which_key,
                        ['<M-p>'] = action_layout.toggle_preview,
                    },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
            },
            pickers = {
                find_files = {
                    previewer = false,
                    theme = 'dropdown',
                },
                live_grep = {
                    previewer = false,
                    theme = 'dropdown',
                },
                grep_string = {
                    previewer = false,
                    theme = 'dropdown',
                },
                help_tags = {
                    previewer = false,
                    theme = 'dropdown',
                },
                diagnostics = {
                    previewer = true,
                    theme = 'cursor',
                    layout_config = {
                        width = 0.6,
                        height = 0.2,
                    },
                },
                lsp_references = {
                    previewer = true,
                    theme = 'ivy',
                },
            },
        })

        local ok = pcall(require('telescope').load_extension, 'fzf')

        if not ok then
            print('Failed to load telescope-fzf-native.nvim')
        end

        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { desc = 'Search: ' .. desc })
        end

        map('<leader><space>', builtin.find_files, 'Search Files')

        map('<leader>sw', builtin.grep_string, 'Search current Word')
        map('<leader>sg', builtin.live_grep, 'Search by Grep')
        map('<leader>sb', builtin.buffers, 'Search for existing Buffers')
        map('<leader>sp', builtin.git_files, 'Search Git Project  Files')
        map('<leader>sr', builtin.lsp_references, 'Search LSP References')

        map('<leader>sd', builtin.diagnostics, ' Search Diagnostics')
        map('<leader>sh', builtin.help_tags, 'Search Help')
        map('<leader>sk', builtin.keymaps, 'Search Keymaps')

        map('<leader>sn', function()
            builtin.find_files({ cwd = vim.fn.stdpath('config') })
        end, 'Search Neovim files')
    end,
}
