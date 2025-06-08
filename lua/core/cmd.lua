vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('HighlightYank', {}),
    desc = 'Hightlight selection on yank',
    pattern = '*',
    callback = function()
        vim.hl.on_yank({ higroup = 'IncSearch', timeout = 500 })
    end,
})

vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
        vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
    end,
    desc = 'Disable New Line Comment',
})

vim.api.nvim_create_autocmd('VimResized', {
    group = vim.api.nvim_create_augroup('WinAutoresize', { clear = true }),
    desc = 'autoresize windows on resizing operation',
    command = 'wincmd =',
})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = vim.api.nvim_create_augroup('ApplyCustomTreesitter', { clear = true }),
    pattern = '.aliasrc',
    callback = function()
        vim.cmd('set filetype=zsh')
    end,
})

local linux_env_user = os.getenv('USER')

vim.api.nvim_create_autocmd('VimLeave', {
    callback = function()
        if linux_env_user == 'maxdep' then
            vim.fn.system('bash ~/.config/nvim/scripts/clean_processes.sh')
        end
    end,
})
