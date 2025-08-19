-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
--     pattern = '.aliasrc',
--     callback = function() vim.cmd('set filetype=zsh') end,
-- })

vim.api.nvim_create_autocmd('BufEnter', {
    desc = 'Disable New Line Comment',
    callback = function() vim.opt.formatoptions:remove({ 'c', 'r', 'o' }) end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Hightlight selection on yank',
    pattern = '*',
    callback = function() vim.hl.on_yank({ higroup = 'IncSearch', timeout = 500 }) end,
})

vim.api.nvim_create_autocmd('VimResized', {
    desc = 'Autoresize windows on resizing operation',
    command = 'wincmd =',
})

vim.api.nvim_create_autocmd('VimLeave', {
    desc = 'Stop duplicated eslint_d, prettierd processes',
    callback = function()
        if os.getenv('USER') == 'maxdep' then vim.fn.system('bash ~/.config/nvim/scripts/clean_processes.sh') end
    end,
})
