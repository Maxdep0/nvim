local cmds = {
    {
        name = 'Stage Buffer',
        fn = function() vim.cmd('Gitsigns stage_buffer') end,
        info = 'Stage current buffer',
    },
    {
        name = 'Stage Hunk',
        fn = function() vim.cmd('Gitsigns stage_hunk') end,
        info = 'Stage current hunk',
    },
    {
        name = 'Undo Stage Hunk',
        fn = function() vim.cmd('Gitsigns undo_stage_hunk') end,
        info = 'Unstage current hunk',
    },
    {
        name = 'Preview Hunk I',
        fn = function() vim.cmd('Gitsigns preview_hunk_inline') end,
        info = 'Show preview hunks inline',
    },
    {
        name = 'Preview Hunk P',
        fn = function() vim.cmd('Gitsigns preview_hunk') end,
        info = 'Show preview hunks in popup',
    },
}

return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',

            build = 'make',

            cond = function() return vim.fn.executable('make') == 1 end,
        },
    },

    config = function()
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        local pickers = require('telescope.pickers')
        local finders = require('telescope.finders')
        local action_layout = require('telescope.actions.layout')
        local actions_state = require('telescope.actions.state')

        require('telescope').setup({
            defaults = {

                file_ignore_patterns = { '.git', 'node_modules', 'dist', 'build', 'target', '__pucache', 'venv' },

                mappings = {
                    i = {
                        ['<esc>'] = actions.close,
                        -- ['<C-h>'] = actions.close,
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-l>'] = actions.select_default,
                        ['<C-_>'] = actions.which_key,
                        ['<C-p>'] = action_layout.toggle_preview,
                        ['<A-p>'] = action_layout.toggle_preview,
                    },
                },
            },

            pickers = {
                find_files = { previewer = false, theme = 'dropdown' },
                grep_string = { previewer = false, theme = 'dropdown' },
                live_grep = { previewer = false, theme = 'dropdown' },
                diagnostics = { previewer = false, theme = 'dropdown' },
                lsp_references = { previewer = true, theme = 'ivy', layout_config = { height = 0.6 } },
                help_tags = { previewer = true, theme = 'ivy', layout_config = { height = 0.6 } },
                keymaps = { previewer = false, theme = 'dropdown', layout_config = { height = 0.7, width = 0.6 } },
            },

            extensions = { fzf = {} },
        })

        require('telescope').load_extension('fzf')

        local fzf_ok = pcall(require('telescope').load_extension, 'fzf')

        if not fzf_ok then print('Failed to load telescope-fzf-native.nvim') end

        local entry_display = require('telescope.pickers.entry_display').create({
            separator = ' │ ',
            items = { { width = 24 }, {}, { remaining = true } },
        })

        local function custom_menu()
            pickers
                .new(require('telescope.themes').get_dropdown({}), {
                    prompt_title = 'Custom Actions',
                    sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
                    finder = finders.new_table({
                        results = cmds,
                        entry_maker = function(entry)
                            return {
                                value = entry,
                                display = function() return entry_display({ entry.name, entry.info or '' }) end,
                                ordinal = entry.name .. ' ' .. (entry.info or ''),
                            }
                        end,
                    }),
                    attach_mappings = function(prompt_bufnr, map1)
                        local select = function()
                            actions.close(prompt_bufnr)
                            actions_state.get_selected_entry().value.fn()
                        end
                        map1({ 'n', 'i' }, '<CR>', select)
                        map1({ 'n', 'i' }, '<C-l>', select)
                        return true
                    end,
                })
                :find()
        end

        local map = function(keys, func, desc) vim.keymap.set('n', keys, func, { desc = desc }) end

        map('<leader><space>', builtin.find_files, 'Search files')
        map('<leader>sw', builtin.grep_string, 'Search word under the cursor')
        map('<leader>sg', builtin.live_grep, 'Search by grep')
        map('<leader>sr', builtin.lsp_references, 'Search LSP references')
        map('<leader>se', builtin.diagnostics, 'Search diagnostics')
        map('<leader>sh', builtin.help_tags, 'Search help')
        map('<leader>sk', builtin.keymaps, 'Search keymaps')
        map('<leader>sc', custom_menu, 'Search commands')

        map('<leader>sn', function() builtin.find_files({ cwd = vim.fn.stdpath('config') }) end, 'Search nvim dir')

        map('<leader>sp', function()
            local project_root = vim.fs.dirname(vim.fs.find('.git', { upward = true })[1]) or vim.fn.getcwd()
            builtin.find_files({ no_ignore = true, hidden = true, cwd = project_root })
        end, 'Search git project from root')
    end,
}
