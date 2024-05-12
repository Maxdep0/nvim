return {
    'lewis6991/gitsigns.nvim',

    config = function()
        require('gitsigns').setup({
            signs = {
                add = { text = '┃' },
                change = { text = '┃' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '┆' },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir = {
                follow_files = true,
            },
            auto_attach = true,
            attach_to_untracked = false,
            current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            current_line_blame_formatter_opts = {
                relative_time = false,
            },
            sign_priority = 6,
            update_debounce = 100,
            status_formatter = nil, -- Use default
            max_file_length = 40000, -- Disable if file is longer than this (in lines)
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1,
            },

            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gitsigns.nav_hunk('next')
                    end
                end, { desc = 'Git: Navigate to the next git hunk' })

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end, { desc = 'Git: Navigate to the previous git hunk' })

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Git: Stage the current hunk for commit' })
                map(
                    'n',
                    '<leader>hr',
                    gitsigns.reset_hunk,
                    { desc = 'Git: Reset the current hunk to the state in HEAD commit' }
                )
                map('v', '<leader>hs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)
                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)
                map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Git: Stage the entire buffer' })
                map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Git: Undo staring of the last staged hunk' })
                map(
                    'n',
                    '<leader>hR',
                    gitsigns.reset_buffer,
                    { desc = 'Git: Resets all changes in the buffer to the state in HEAD commit' }
                )
                map(
                    'n',
                    '<leader>hp',
                    gitsigns.preview_hunk,
                    { desc = 'Git: Open a preview window showing the current hunk' }
                )
                map('n', '<leader>hb', function()
                    gitsigns.blame_line({ full = true })
                end, { desc = 'Git: Open git blame information for the current line' })
                map(
                    'n',
                    '<leader>tb',
                    gitsigns.toggle_current_line_blame,
                    { desc = 'Git: Toggle git blame info for current line' }
                )
                map(
                    'n',
                    '<leader>hd',
                    gitsigns.diffthis,
                    { desc = 'Git: Show a diff of the currect file against the HEAD commit' }
                )
                map('n', '<leader>hD', function()
                    gitsigns.diffthis('~')
                end, { desc = 'Git: Show a diff for current file against against the previous commit' })
                map(
                    'n',
                    '<leader>td',
                    gitsigns.toggle_deleted,
                    { desc = 'Git: Toggle visibility of deleted lines in the diff view' }
                )

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end,
        })
    end,
}
