return {
    dir = vim.fn.stdpath('config') .. '/lua',
    name = 'custom-statusline',
    dependencies = {
        'lewis6991/gitsigns.nvim',
    },
    config = function() require('custom_statusline').setup() end,
}
