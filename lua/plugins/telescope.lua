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

        require('telescope').setup({
            defaults = {
                path_display = { 'smart' },

                file_ignore_patterns = { '.git/', 'node_modules', 'dist', 'build', 'target', '__pycache__', 'venv' },

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
                find_files = { previewer = false, theme = 'dropdown' },
                live_grep = { previewer = false, theme = 'dropdown' },
                grep_string = { previewer = false, theme = 'dropdown' },
                buffers = { previewer = false, theme = 'dropdown' },
                git_files = { previewer = false, theme = 'dropdown' },
                lsp_references = { previewer = false, theme = 'dropdown', layout_config = { width = 0.6 } },
                diagnostics = { previewer = false, theme = 'dropdown', layout_config = { width = 0.6 } },
                help_tags = { previewer = false, theme = 'dropdown' },
                keymaps = { previewer = false, theme = 'dropdown', layout_config = { width = 0.6 } },
                lsp_document_symbols = { previewer = false, theme = 'dropdown', layout_config = { width = 0.6 } },
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

        map('<leader>sw', builtin.grep_string, 'Search current word')
        map('<leader>sg', builtin.live_grep, 'Search by grep')
        map('<leader>sb', builtin.buffers, 'Search for existing buffers')
        map('<leader>sp', function()
            local project_root = vim.fs.dirname(vim.fs.find('.git', { upward = true })[1]) or vim.fn.getcwd()
            builtin.find_files({ no_ignore = true, hidden = true, cwd = project_root })
        end, 'Search project files from project root')

        map('<leader>sr', builtin.lsp_references, 'Search LSP references')
        map('<leader>sd', builtin.diagnostics, 'Search diagnostics')
        map('<leader>sh', builtin.help_tags, 'Search help')
        map('<leader>sk', builtin.keymaps, 'Search keymaps')
        map('<leader>ss', builtin.lsp_document_symbols, 'Search document symbols')

        map('<leader>sn', function()
            builtin.find_files({ cwd = vim.fn.stdpath('config') })
        end, 'Search neovim files')
    end,
}
