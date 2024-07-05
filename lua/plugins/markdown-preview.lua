return {
    {
        -- install without yarn or npm
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        cond = false,
        build = function()
            vim.fn['mkdp#util#install']()
        end,
    },
    {
        -- install with yarn or npm
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        build = 'cd app && yarn install',
        cond = false,
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        ft = { 'markdown' },
    },
}
