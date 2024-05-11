return {
    'mbbill/undotree',

    config = function()
        vim.keymap.set('n', '<F5>', vim.cmd.UndotreeToggle, { desc = 'Keymap: Toggle Undo Tree' })
    end,
}
