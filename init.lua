vim.fn.setenv('ESLINT_USE_FLAT_CONFIG', 'true')

require('core')

toggleTransparency()

vim.keymap.set('n', '<F5>', ':!python %<CR>', { noremap = true, silent = true, desc = 'Run Python script' })
