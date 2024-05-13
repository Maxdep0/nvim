return {
    'folke/which-key.nvim',
    event = 'VeryLazy',

    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300

        require('which-key').setup({

            window = {
                border = 'double',
                position = 'top',
                margin = { 0, 0, 0, 0 },
                padding = { 0, 0, 0, 0 },
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 5,
                align = 'center',
            },
        })
    end,
}
