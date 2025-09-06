-- vim.fn.setenv('ESLINT_USE_FLAT_CONFIG', 'true')

vim.cmd('colorscheme maxo')
require('core')
-- require('core.toggles').toggle_transparency()

vim.keymap.set('n', '<leader>i', function()
    vim.cmd('Inspect')
    print(vim.inspect(vim.treesitter.get_captures_at_cursor(0)))
end)

vim.api.nvim_create_user_command('Hi', function(opts) vim.cmd('filter /' .. opts.args .. '/ hi') end, { nargs = 1 })
