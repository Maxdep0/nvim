local M = {}

function toggleTransparent()
    local ok, transparent = pcall(vim.api.nvim_get_var, 'isTransparent')

    if not ok or not transparent then
        M.notify('Enabled Transparent Background', 'UI')
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })

        vim.api.nvim_set_var('isTransparent', true)
    elseif transparent then
        M.notify('Disabled Transparent Background', 'UI')
        vim.cmd('colorscheme nightfox')
        vim.api.nvim_set_var('isTransparent', false)
    end
end

function M.notify(msg, ann)
    local _, fidget = pcall(require, 'fidget')
    fidget.notify(msg, vim.log.levels.INFO, { annote = ann })
end

return M
