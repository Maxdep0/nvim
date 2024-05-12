function toggleTransparent()
    local ok, transparent = pcall(vim.api.nvim_get_var, 'isTransparent')

    if not ok or not transparent then
        print('Enabled Transparent Background')
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })

        vim.api.nvim_set_var('isTransparent', true)
    elseif transparent then
        print('Disabled Transparent Background')
        vim.cmd('colorscheme nightfox')
        vim.api.nvim_set_var('isTransparent', false)
    end
end
