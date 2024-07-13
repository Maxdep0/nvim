-- stylua: ignore
return {
    'lewis6991/gitsigns.nvim',
    config = function()


        require('gitsigns').setup({
            signs = {
                add = { text = '┃' },
                change = { text = '┃' },
                delete = { text = '┃' },
                topdelete = { text = '-' },
                changedelete = { text = '~' },
                untracked = { text = '┆' },
            },

            signcolumn = true,
            attach_to_untracked = true,
            current_line_blame = true,
            max_file_length = 20000,

            on_attach = function(bufnr)
                local gs = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, '<leader>'.. l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']c', bang = true })
                    else
                        gs.nav_hunk('next')
                    end
                end, { desc = 'Git: Navigate to the next git hunk' })

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[c', bang = true })
                    else
                        gs.nav_hunk('prev')
                    end
                end, { desc = 'Git: Navigate to the previous git hunk' })

                map({'n', 'v'}, '<F9>', ':Gitsigns stage_hunk<CR>',                    { desc = 'Git: [H]unt [S]tage for commit' })
                -- map({'n', 'v'}, 'hR', ':Gitsigns reset_hunk<CR>',                    { desc = 'Git: [H]unt [R]eset to the state in HEAD commit' })
                map('n',        '<F10>', gs.stage_buffer,                               { desc = 'Git: [H]unt [S]tage entire file' })
                -- map('n',        'hU', gs.undo_stage_hunk,                            { desc = 'Git: [H]unt [U]ndo staging of the last staged hunk' })
                -- map('n',        'hd', gs.diffthis,                                   { desc = 'Git: [H]unt [D]iff for current file against the HEAD commit' })
                -- map('n',        'hD', function() gs.diffthis('~') end,               { desc = 'Git: [H]unt [D]iff for current file against the previous commit' })
                map('n',        '<F11>', gs.preview_hunk,                               { desc = 'Git: [T]oggle [D]elete preview window showing current hunk' })
                map('n',        '<F12>', gs.toggle_deleted,                             { desc = 'Git: [T]oggle [D]iff view of deleted lines in current file' })
                -- map('n',        'tb', function() gs.blame_line({ full = true }) end, { desc = 'Git: [T]oggle [B]lame info for the current hunk' })
                -- map('n',        'tB', gs.toggle_current_line_blame,                  { desc = 'Git: [T]oggle [B]lame info for current line' })
            end,
        })
    end,
}
