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
        })
    end,
}
