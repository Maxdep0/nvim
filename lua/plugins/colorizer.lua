return {
    'NvChad/nvim-colorizer.lua',
    ft = { 'css', 'sass', 'html', 'lua' },
    config = function()
        require('colorizer').setup({
            filetypes = { '*' },
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                names = false,
                RRGGBBAA = true,
                AARRGGBB = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                mode = 'background',
                tailwind = true,
                sass = { enable = true, parsers = { 'css' } },
                virtualtext = '■',
                always_update = true,
            },
            buftypes = {},
        })
    end,
}
