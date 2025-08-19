--
--     styles = { comments = 'italic', keywords = 'bold', types = 'italic,bold', operators = 'bold', strings = 'italic', functions = 'bold', conditionals = 'bold', },
-- },
--
--         bg0 = '#2d353b', -- status line and float
--         -- bg1 = '#2d353b', -- default bg -- NOTE: CHANGE LATER
--         bg1 = '#000000', -- default bg
--         bg2 = '#353d43', -- colorcolumn folds
--         bg3 = '#3a4248', -- cursor line
--         bg4 = '#acb4ba', -- Conceal, border fg
--
--         -- fg0 = '#c7cdd9',
--         fg1 = '#c5d1de',
--         -- fg2 = '#ffffff',
--         fg3 = '#778491',
--
--         sel0 = '#3e4a5b', -- Popup bg, visual selection bg
--         sel1 = '#4f6074', -- Popup sel bg, search bg
--
--         comment = '#9a9a9a',
-- },

local function hex_to_rgb(hex)
    local r, g, b = hex:match('#?(%x%x)(%x%x)(%x%x)')
    return { r = tonumber(r, 16), g = tonumber(g, 16), b = tonumber(b, 16) }
end

local rgb_to_hex = function(rgb) return string.format('#%02x%02x%02x', rgb.r, rgb.g, rgb.b) end

local clamp = function(val) return math.max(0, math.min(255, math.floor(val + 0.5))) end

local lighten = function(color, percent)
    local rgb = hex_to_rgb(color)
    local factor = percent / 100
    return rgb_to_hex({
        r = clamp(rgb.r + (255 - rgb.r) * factor),
        g = clamp(rgb.g + (255 - rgb.g) * factor),
        b = clamp(rgb.b + (255 - rgb.b) * factor),
    })
end

local darken = function(color, percent)
    local rgb = hex_to_rgb(color)
    local factor = 1 - (percent / 100)
    return rgb_to_hex({
        r = clamp(rgb.r * factor),
        g = clamp(rgb.g * factor),
        b = clamp(rgb.b * factor),
    })
end

local M = {}

M.apply_colorscheme = function()
    local hl = vim.api.nvim_set_hl

    local clr = {
        bg = '#1a1a1a', -- Main background
        fg = '#e0e0e0', -- Main text
    }

    local colors = {
        -- Main colors
        bg = clr.bg,
        bg_alt = lighten(clr.bg, '3'),
        fg = lighten(clr.fg, '30'),
        fg_dim = lighten(clr.bg, '50'),

        -- Accent colors
        red = '#ff6b6b',
        green = '#95e454',
        yellow = '#f4bf75',
        blue = '#66d9ef',
        purple = '#ae81ff',
        cyan = '#46d9ff',
        orange = '#fd971f',
        lime = '#a6e22e',

        -- UI elements
        border = '#404040',
        selection = '#3a3a3a',
        -- cursor_line = '#2a2a2a',
        cursor_line = lighten(clr.bg, '3'),

        -- status line
        sl_text = lighten(clr.fg, '40'),
        active_buffer = lighten(clr.fg, '25'),

        -- Diagnostics
        error = '#ff5555',
        warn = '#f1fa8c',
        info = '#8be9fd',
        hint = '#50fa7b',
    }

    -- Editor basics
    hl(0, 'Normal', { fg = colors.fg, bg = colors.bg })
    hl(0, 'NormalFloat', { fg = colors.fg, bg = colors.bg_alt })
    hl(0, 'LineNr', { fg = colors.fg_dim })
    hl(0, 'CursorLine', { bg = colors.cursor_line })
    hl(0, 'CursorLineNr', { fg = colors.yellow }) ----------------
    hl(0, 'Visual', { bg = colors.selection })
    hl(0, 'Search', { fg = colors.bg, bg = colors.yellow })
    hl(0, 'IncSearch', { fg = colors.bg, bg = colors.orange })

    -- UI elements
    hl(0, 'WinSeparator', { fg = colors.purple })
    hl(0, 'VertSplit', { fg = colors.purple })
    hl(0, 'SignColumn', { fg = colors.red, bg = 'NONE' })

    -- Status line
    hl(0, 'StatusLine', { fg = colors.sl_text, bg = colors.bg_alt })
    hl(0, 'StatusLineNC', { fg = colors.fg_dim, bg = colors.bg_alt })
    hl(0, 'StatuslineGit', { fg = lighten(colors.yellow, '10'), bg = 'NONE', bold = true })
    hl(0, 'StatuslineLSP', { fg = colors.sl_text, bg = 'NONE' })
    hl(0, 'StatuslineNormal', { fg = colors.active_buffer, bg = 'NONE', bold = true })
    hl(0, 'statusLineDiffAdd', { fg = lighten(colors.green, '30'), bg = 'NONE', bold = true })
    hl(0, 'StatuslineDiffMod', { fg = lighten(colors.orange, '30'), bg = 'NONE', bold = true })
    hl(0, 'StatuslineDiffDel', { fg = lighten(colors.red, '30'), bg = 'NONE', bold = true })
    hl(0, 'StatuslineDiagError', { fg = colors.red, bg = 'NONE' })
    hl(0, 'StatuslineDiagWarn', { fg = colors.yellow, bg = 'NONE' })
    hl(0, 'StatuslineDiagInfo', { fg = colors.green, bg = 'NONE' })
    hl(0, 'StatuslineDiagHint', { fg = colors.cyan, bg = 'NONE' })
    hl(0, 'StatuslineInactive', { fg = darken(colors.active_buffer, '30'), bg = 'NONE' })

    -- Popup menu
    hl(0, 'Pmenu', { fg = colors.fg, bg = colors.bg_alt })
    hl(0, 'PmenuSel', { fg = colors.bg, bg = colors.blue })
    hl(0, 'PmenuSbar', { bg = colors.bg_alt })
    hl(0, 'PmenuThumb', { bg = colors.fg_dim })

    -- Messages
    hl(0, 'ErrorMsg', { fg = colors.red })
    hl(0, 'WarningMsg', { fg = colors.yellow })
    hl(0, 'Question', { fg = colors.blue })
    hl(0, 'MoreMsg', { fg = colors.green })

    -- Diagnostics
    hl(0, 'DiagnosticError', { fg = darken(colors.error, '40') })
    hl(0, 'DiagnosticWarn', { fg = darken(colors.warn, '40') })
    hl(0, 'DiagnosticInfo', { fg = darken(colors.info, '40') })
    hl(0, 'DiagnosticHint', { fg = darken(colors.hint, '40') })

    -- Git/Diff
    hl(0, 'DiffAdd', { bg = '#1a3a1a' })
    hl(0, 'DiffChange', { bg = '#3a3a1a' })
    hl(0, 'DiffDelete', { bg = '#3a1a1a' })
    hl(0, 'DiffText', { bg = '#4a4a1a' })
    hl(0, 'GitSignsAdd', { fg = colors.green })
    hl(0, 'GitSignsChange', { fg = colors.yellow })
    hl(0, 'GitSignsDelete', { fg = colors.red })

    -- Treesitter
    hl(0, '@variable', { fg = colors.fg })
    hl(0, '@function', { fg = colors.cyan })
    hl(0, '@function.call', { fg = colors.cyan })
    hl(0, '@keyword', { fg = colors.red })
    hl(0, '@string', { fg = colors.green })
    hl(0, '@number', { fg = colors.purple })
    hl(0, '@boolean', { fg = colors.purple })
    hl(0, '@comment', { fg = darken(colors.fg_dim, '20') })
    hl(0, '@type', { fg = colors.blue })
    hl(0, '@operator', { fg = colors.red })
    hl(0, '@punctuation', { fg = colors.fg })
    hl(0, '@constant', { fg = colors.purple })
    hl(0, '@tag', { fg = colors.red })
    hl(0, '@attribute', { fg = colors.yellow })
    hl(0, '@property', { fg = colors.fg })
end

M.apply_colorscheme()

vim.api.nvim_create_user_command('MaxoTheme', M.apply_colorscheme, {})

return M
