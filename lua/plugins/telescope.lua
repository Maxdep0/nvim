return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    cond = true,

    config = function()
        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader><space>', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fp', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fm', builtin.keymaps, {})
    end,
}
