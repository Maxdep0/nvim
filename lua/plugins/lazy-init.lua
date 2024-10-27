return {
    { 'numToStr/Comment.nvim', opts = {} },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = function()
            require('nvim-autopairs').setup({})
        end,
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle, { desc = 'Keymap: Toggle Undo Tree' })
        end,
    },
    {
        'ray-x/lsp_signature.nvim',
        config = function()
            require('lsp_signature').setup()
        end,
    },
}
