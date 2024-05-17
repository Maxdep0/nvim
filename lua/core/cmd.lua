vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
    desc = 'Hightlight selection on yank',
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 500 })
    end,
})

vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
        vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
    end,
    desc = 'Disable New Line Comment',
})

vim.api.nvim_create_autocmd('VimResized', {
    group = vim.api.nvim_create_augroup('win_autoresize', { clear = true }),
    desc = 'autoresize windows on resizing operation',
    command = 'wincmd =',
})
