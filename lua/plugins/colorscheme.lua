return {
    'EdenEast/nightfox.nvim',
    priority = 999,
    cond = true,

    config = function()
        require('nightfox').setup({
            options = {
                transparent = false,
            },
            palettes = {
                nightfox = {
                    bg0 = '#2d353b', -- status line and float
                    bg1 = '#2d353b', -- default bg
                    bg2 = '#343F44', -- colorcolumn folds
                    bg3 = '#343f44', -- cursor line
                    bg4 = '#7A8478', -- Conceal, border fg
                    sel0 = '#3d484d', -- Popup bg, visual selection bg
                    sel1 = '#7A8478', -- Popup sel bg, search bg
                    comment = '#7b7b7b',
                },
            },
        })
        vim.cmd('colorscheme nightfox')
    end,
}
