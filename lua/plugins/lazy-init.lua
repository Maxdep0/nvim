return {
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        cond = false,
        config = function() require('nvim-autopairs').setup({}) end,
    },
    {
        'norcalli/nvim-colorizer.lua',
        event = 'InsertEnter',
        cond = false,
        config = function() require('colorizer').setup() end,
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle, { desc = 'Keymap: Toggle Undo Tree' })
        end,
    },
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        cond = false,
        build = function() vim.fn['mkdp#util#install']() end,
    },
    {
        dir = vim.fn.stdpath('config') .. '/lua',
        name = 'custom-statusline',
        dependencies = {
            'lewis6991/gitsigns.nvim',
        },
        config = function() require('custom_statusline').setup() end,
    },
}
