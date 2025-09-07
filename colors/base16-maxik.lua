vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then vim.cmd('syntax reset') end

vim.g.colors_name = 'base16-maxik'

local u = require('core.utils')
local lighten, darken = u.lighten, u.darken
local hl = vim.api.nvim_set_hl

if vim.fn.has('termguicolors') == 1 then vim.o.termguicolors = true end

local base00 = '#1a1a1a' -- background
local base01 = '#262626' -- lighter background (status bars, line numbers)
local base02 = '#3a3a3a' -- selection background / highlights
local base03 = '#4e4e4e' -- comments / subtle text
local base04 = '#8a8a8a' -- dark foreground (status text)
local base05 = '#e0e0e0' -- default foreground, main text
local base06 = '#f0f0f0' -- light foreground (strong emphasis)
local base07 = '#ffffff' -- lightest foreground (white, borders)

local base08 = '#CC6666' -- variables, errors, important
local base09 = '#DE935F' -- nums, const, warnings
local base0A = '#F0C674' -- classes, types, highlights
local base0B = '#98c379' -- strings, success, added
local base0C = '#8ABEB7' -- support, regex, special
local base0D = '#81A2BE' -- functions, methods, keywords
local base0E = '#B294BB' -- keywords, operators, important
local base0F = '#C678DD' -- deprecated, special cases

local theme = {
    bg = base00,
    bg_alt = base01,
    bg_subtle = base02,

    fg = base05,
    fg_dim = base04,
    fg_light = base06,

    red = base08,
    orange = base09,
    yellow = base0A,
    green = base0B,
    cyan = base0C,
    blue = base0D,
    purple = base0E,
    magenta = base0F,

    border = base03,
    selection = base02,
    cursor_line = lighten(base00, 3),

    -- sl_text = base05,
    -- active_buffer = base06,

    comment = base03,
    tag = base03,

    statusline = {
        mode = {
            red = lighten(base08, 45),
            orange = lighten(base09, 30),
            yellow = lighten(base0A, 26),
            green = lighten(base0B, 15),
            cyan = lighten(base0C, 20),
            blue = lighten(base0D, 15),
            purple = lighten(base0E, 15),
        },
        buffers = {
            active = base06,
            inactive = darken(base06, 30),
            lsp = base05,
        },
        git = {
            branch = lighten(base0A, 5),
            added = lighten(base0B, 15),
            changed = lighten(base09, 15),
            deleted = lighten(base08, 15),
        },
        diff = {
            added = lighten(base0B, 15),
            modified = lighten(base0A, 15),
            deleted = lighten(base08, 15),
        },
        diag = {
            error = '#FF6B6B',
            warn = '#F4BF75',
            info = '#46D9FF',
            hint = '#A6E22E',
        },
    },

    todo = {
        todo = lighten(base0A, 10),
        error = lighten(base08, 15),
        warn = lighten(base09, 10),
        info = lighten(base0C, 18),
        bug = lighten(base08, 15),
        performance = lighten(base0D, 15),
        test = lighten(base0E, 10),
        hack = lighten(base09, 15),
    },

    error = '#FF6B6B',
    warn = '#F4BF75',
    info = '#46D9FF',
    hint = '#A6E22E',
}

-- stylua: ignore start
hl(0, 'Normal',                          { fg = theme.fg, bg = theme.bg })
hl(0, 'LineNr',                          { fg = theme.fg_dim })
hl(0, 'CursorLine',                      { bg = theme.cursor_line })
hl(0, 'CursorLineNr',                    { fg = theme.yellow })
hl(0, 'Visual',                          { bg = theme.selection })
hl(0, 'Search',                          { fg = theme.bg, bg = theme.yellow })
hl(0, 'IncSearch',                       { fg = theme.bg, bg = theme.orange })

hl(0, 'NormalFloat',                     { fg = theme.fg, bg = theme.bg_alt })
hl(0, 'FloatBorder',                     { fg = theme.border, bg = theme.bg_alt })
hl(0, 'FloatTitle',                      { fg = theme.yellow, bg = theme.bg_alt, bold = true })

hl(0, 'WinSeparator',                    { fg = theme.purple })
hl(0, 'VertSplit',                       { fg = theme.purple })
hl(0, 'SignColumn',                      { fg = 'NONE', bg = 'NONE' })

-- hl(0, 'StatusLine',                      { fg = theme.sl_text, bg = theme.bg_alt })
hl(0, 'StatusLine',                      { fg = theme.fg, bg = theme.bg_alt })
hl(0, 'StatusLineNC',                    { fg = theme.fg_dim, bg = theme.bg_alt })
-- hl(0, 'StatuslineLSP',                   { fg = theme.sl_text, bg = 'NONE' })
-- hl(0, 'StatuslineNormal',                { fg = theme.active_buffer, bg = 'NONE', bold = true })
-- hl(0, 'StatuslineInactive',              { fg = darken(theme.active_buffer, 30), bg = 'NONE' })

hl(0, 'Pmenu',                           { fg = theme.fg, bg = theme.bg_alt })
hl(0, 'PmenuSel',                        { fg = theme.bg, bg = theme.blue })
hl(0, 'PmenuSbar',                       { bg = theme.bg_alt })
hl(0, 'PmenuThumb',                      { bg = theme.fg_dim })

-- hl(0, 'StatuslineDiagError',             { fg = theme.error, bg = 'NONE' })
-- hl(0, 'StatuslineDiagWarn',              { fg = theme.warn, bg = 'NONE' })
-- hl(0, 'StatuslineDiagInfo',              { fg = theme.info, bg = 'NONE' })
-- hl(0, 'StatuslineDiagHint',              { fg = theme.hint, bg = 'NONE' })

hl(0, 'DiagnosticError',                 { fg = darken(theme.error, 40) })
hl(0, 'DiagnosticWarn',                  { fg = darken(theme.warn, 40) })
hl(0, 'DiagnosticInfo',                  { fg = darken(theme.info, 40) })
hl(0, 'DiagnosticHint',                  { fg = darken(theme.hint, 40) })

hl(0, 'ErrorMsg',                        { fg = theme.error })
hl(0, 'WarningMsg',                      { fg = theme.warn })
hl(0, 'Question',                        { fg = theme.blue })
hl(0, 'MoreMsg',                         { fg = theme.green })

-- hl(0, 'StatuslineGit',                   { fg = theme.yellow, bg = 'NONE', bold = true })
-- hl(0, 'GitSignsAdd',                     { fg = theme.green, bg = 'NONE' })
-- hl(0, 'GitSignsChange',                  { fg = theme.orange, bg = 'NONE' })
-- hl(0, 'GitSignsDelete',                  { fg = theme.red, bg = 'NONE' })

-- hl(0, 'StatusLineDiffAdd',               { fg = lighten(theme.green, 15), bg = 'NONE', bold = true })
-- hl(0, 'StatuslineDiffMod',               { fg = lighten(theme.yellow, 15), bg = 'NONE', bold = true })
-- hl(0, 'StatuslineDiffDel',               { fg = lighten(theme.red, 15), bg = 'NONE', bold = true })

hl(0, 'DiffAdd',                         { bg = lighten(theme.green, 40) })
hl(0, 'DiffChange',                      { bg = lighten(theme.yellow, 45) })
hl(0, 'DiffDelete',                      { bg = lighten(theme.red, 40) })
hl(0, 'DiffText',                        { bg = lighten(theme.blue, 45) }) 



hl(0, '@variable',                       { fg = theme.fg }) 

hl(0, '@variable.builtin',               { fg = theme.red, italic = true })
hl(0, '@variable.parameter',             { fg = theme.orange }) 
hl(0, '@variable.parameter.builtin',     { fg = theme.orange, italic = true }) 
hl(0, '@variable.member',                { fg = theme.blue })   

hl(0, '@constant',                       { fg = theme.magenta, bold = true })
hl(0, '@constant.builtin',               { fg = theme.magenta, bold = true }) 
hl(0, '@constant.macro',                 { fg = theme.magenta, italic = true }) 

hl(0, '@module',                         { fg = theme.yellow }) 
hl(0, '@module.builtin',                 { fg = theme.yellow, italic = true }) 
hl(0, '@label',                          { fg = theme.red, bold = true }) 

hl(0, '@string',                         { fg = theme.green }) 
hl(0, '@string.documentation',           { fg = theme.green, italic = true })
hl(0, '@string.regexp',                  { fg = theme.cyan, bold = true })
hl(0, '@string.escape',                  { fg = theme.yellow })
hl(0, '@string.special',                 { fg = theme.cyan }) 
hl(0, '@string.special.symbol',          { fg = theme.purple })
hl(0, '@string.special.path',            { fg = theme.blue })
hl(0, '@string.special.url',             { fg = theme.blue, underline = true }) 

hl(0, '@character',                      { fg = theme.green }) 
hl(0, '@character.special',              { fg = theme.yellow })
hl(0, '@boolean',                        { fg = theme.magenta, bold = true }) 
hl(0, '@number',                         { fg = theme.cyan }) 
hl(0, '@number.float',                   { fg = theme.cyan, italic = true })

hl(0, '@type',                           { fg = theme.yellow }) 
hl(0, '@type.builtin',                   { fg = theme.yellow, italic = true }) 
hl(0, '@type.definition',                { fg = theme.yellow, bold = true }) 

hl(0, '@attribute',                      { fg = theme.orange })
hl(0, '@attribute.builtin',              { fg = theme.orange, italic = true }) 
hl(0, '@property',                       { fg = theme.blue })

hl(0, '@function',                       { fg = theme.blue, bold = true }) 
hl(0, '@function.builtin',               { fg = theme.cyan, bold = true }) 
hl(0, '@function.call',                  { fg = theme.blue }) 
hl(0, '@function.macro',                 { fg = theme.purple, bold = true }) 
hl(0, '@function.method',                { fg = theme.blue, bold = true }) 
hl(0, '@function.method.call',           { fg = theme.blue }) 
hl(0, '@constructor',                    { fg = theme.yellow, bold = true }) 

hl(0, '@operator',                       { fg = theme.red, bold = true })

hl(0, '@keyword',                        { fg = theme.purple })
hl(0, '@keyword.coroutine',              { fg = theme.magenta, bold = true })
hl(0, '@keyword.function',               { fg = theme.magenta, bold = true })
hl(0, '@keyword.operator',               { fg = theme.red, italic = true }) 
hl(0, '@keyword.import',                 { fg = theme.cyan, bold = true })
hl(0, '@keyword.type',                   { fg = theme.yellow, bold = true }) 
hl(0, '@keyword.modifier',               { fg = theme.orange, bold = true }) 
hl(0, '@keyword.repeat',                 { fg = theme.orange, bold = true }) 
hl(0, '@keyword.return',                 { fg = theme.red, bold = true }) 
hl(0, '@keyword.debug',                  { fg = theme.magenta, bold = true }) 
hl(0, '@keyword.exception',              { fg = theme.red, bold = true }) 
hl(0, '@keyword.conditional',            { fg = theme.orange, bold = true }) 
hl(0, '@keyword.conditional.ternary',    { fg = theme.orange, bold = true }) 
hl(0, '@keyword.directive',              { fg = theme.purple }) 
hl(0, '@keyword.directive.define',       { fg = theme.purple, bold = true }) 

hl(0, '@punctuation.delimiter',          { fg = theme.fg_dim })
hl(0, '@punctuation.bracket',            { fg = theme.orange })
hl(0, '@punctuation.special',            { fg = theme.red })

hl(0, '@comment',                        { fg = theme.comment })

hl(0, '@diff.plus',                      { fg = theme.green })
hl(0, '@diff.minus',                     { fg = theme.red })
hl(0, '@diff.delta',                     { fg = theme.orange })

vim.g.base16_gui00 = base00  
vim.g.base16_gui01 = base01  
vim.g.base16_gui02 = base02  
vim.g.base16_gui03 = base03  
vim.g.base16_gui04 = base04  
vim.g.base16_gui05 = base05  
vim.g.base16_gui06 = base06  
vim.g.base16_gui07 = base07  
vim.g.base16_gui08 = base08  
vim.g.base16_gui09 = base09  
vim.g.base16_gui0A = base0A  
vim.g.base16_gui0B = base0B  
vim.g.base16_gui0C = base0C  
vim.g.base16_gui0D = base0D  
vim.g.base16_gui0E = base0E  
vim.g.base16_gui0F = base0F  

vim.g.base16_statusline_mode = theme.statusline.mode
vim.g.base16_statusline = theme.statusline
vim.g.base16_todo = theme.todo
