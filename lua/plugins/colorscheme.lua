return {
    'EdenEast/nightfox.nvim',
    priority = 999,

    config = function()
        require('nightfox').setup({
            options = {
                transparent = false,

                -- dim_inactive = true,
                styles = {
                    comments = 'italic',
                    keywords = 'bold',
                    types = 'italic,bold',
                    operators = 'bold',
                    strings = 'italic',
                    functions = 'bold',
                    conditionals = 'bold',
                },
            },

            palettes = {
                nightfox = {
                    bg0 = '#2d353b', -- status line and float
                    bg1 = '#2d353b', -- default bg
                    bg2 = '#353d43', -- colorcolumn folds
                    bg3 = '#3a4248', -- cursor line
                    bg4 = '#acb4ba', -- Conceal, border fg

                    -- fg0 = '#c7cdd9',
                    fg1 = '#c5d1de',
                    -- fg2 = '#ffffff',
                    fg3 = '#778491',

                    sel0 = '#3e4a5b', -- Popup bg, visual selection bg
                    sel1 = '#4f6074', -- Popup sel bg, search bg

                    comment = '#9a9a9a',
                },
            },
        })

        vim.cmd('colorscheme nightfox')
        vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#000000', bg = 'none' })
    end,
}
