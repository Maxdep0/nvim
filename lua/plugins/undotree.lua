return {
    'mbbill/undotree',
    cond = true,

    config = function()
        vim.keymap.set('n', '<F5>', vim.cmd.UndotreeToggle)
    end,
}
