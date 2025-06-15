return {
    { 'numToStr/Comment.nvim', opts = {} },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function() require('nvim-autopairs').setup({}) end,
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
}
