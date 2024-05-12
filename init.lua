vim.fn.setenv('ESLINT_USE_FLAT_CONFIG', 'true')

require('config')
require('utils')

-- Just for debugging
vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
    group = vim.api.nvim_create_augroup('KillPrettierAndEslint', { clear = true }),
    callback = function()
        vim.fn.system('prettierd stop')
        vim.fn.system('eslint_d stop')
    end,
})

function kill()
    vim.cmd('LspStop')
    vim.fn.system('taskkill /F /IM node.exe')
    vim.fn.system('prettierd stop')
    vim.fn.system('prettierd stop')
end

vim.keymap.set('n', '<S-F5>', ':lua kill()<CR>')
