vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then vim.cmd('syntax reset') end
vim.g.colors_name = 'maxo'

local u = require('core.utils')
local lighten, darken = u.lighten, u.darken

local hl = vim.api.nvim_set_hl

if vim.fn.has('termguicolors') == 1 then vim.o.termguicolors = true end


-- stylua: ignore start
local palettes = {
  pastel = {
    red     = '#FFB3BA', orange  = '#FFDAB3', yellow  = '#FFFFBA', green   = '#B5EAD7',
    cyan    = '#BAE1FF', blue    = '#AEC6CF', purple  = '#CBAACB', magenta = '#FFB3E6',
    pink    = '#FFD1DC', gray    = '#E6E6E6', black   = '#2E2E2E', white   = '#FFFFFF', },
  soft_pastel = {
    red     = '#F4A6A6', orange  = '#FFCC99', yellow  = '#FFF2A1', green   = '#A8E6CF',
    cyan    = '#AEEEEE', blue    = '#89CFF0', purple  = '#D7BDE2', magenta = '#F3C4FB',
    pink    = '#FEC8D8', gray    = '#CCCCCC', black   = '#262626', white   = '#FAFAFA', },
  muted_pastel = {
    red     = '#C48B8B', orange  = '#D6A77A', yellow  = '#D9CBA3', green   = '#88A096',
    cyan    = '#9AB8B8', blue    = '#9BB7D4', purple  = '#BFA5A0', magenta = '#C6B5C9',
    pink    = '#D8A7B1', gray    = '#999999', black   = '#1F1F1F', white   = '#EDEDED', },
  vivid = {
    red     = '#FF6B6B', orange  = '#FD971F', yellow  = '#F4BF75', green   = '#A6E22E',
    cyan    = '#46D9FF', blue    = '#66D9EF', purple  = '#AE81FF', magenta = '#FF00FF',
    pink    = '#FF66CC', gray    = '#808080', black   = '#000000', white   = '#FFFFFF', },
  neon = {
    red     = '#FF073A', orange  = '#FF7F11', yellow  = '#F9F871', green   = '#39FF14',
    cyan    = '#0FF0FC', blue    = '#1B03A3', purple  = '#BC13FE', magenta = '#FF44CC',
    pink    = '#FF10F0', gray    = '#7D7D7D', black   = '#0A0A0A', white   = '#F0F0F0', },
  jewel = {
    red     = '#9B111E', orange  = '#E25822', yellow  = '#FFD700', green   = '#50C878',
    cyan    = '#48D1CC', blue    = '#0F52BA', purple  = '#6A0DAD', magenta = '#C71585',
    pink    = '#E75480', gray    = '#5C5C5C', black   = '#101010', white   = '#F8F8F8', },
  earth = {
    red     = '#A0522D', orange  = '#CC7722', yellow  = '#D2B48C', green   = '#556B2F',
    cyan    = '#708090', blue    = '#4682B4', purple  = '#8B668B', magenta = '#915C83',
    pink    = '#C08081', gray    = '#7F7F7F', black   = '#2B2B2B', white   = '#F5F5DC', },
  neutral = {
    red     = '#CC6666', orange  = '#DE935F', yellow  = '#F0C674', green   = '#B5BD68',
    cyan    = '#8ABEB7', blue    = '#81A2BE', purple  = '#B294BB', magenta = '#C678DD',
    pink    = '#D6A5B0', gray    = '#ABABAB', black   = '#1E1E2E', white   = '#F8F8F2', },
  retro = {
    red     = '#E63946', orange  = '#F77F00', yellow  = '#FFDD00', green   = '#06D6A0',
    cyan    = '#4CC9F0', blue    = '#4361EE', purple  = '#7209B7', magenta = '#B5179E',
    pink    = '#FF6F91', gray    = '#A9A9A9', black   = '#212121', white   = '#FAF3E0', },
  cyberpunk = {
    red     = '#FF003C', orange  = '#FF8C00', yellow  = '#F5F749', green   = '#00FF9C',
    cyan    = '#00E5FF', blue    = '#00AEEF', purple  = '#7A00FF', magenta = '#FF00E5',
    pink    = '#FF1493', gray    = '#5A5A5A', black   = '#0D0D0D', white   = '#F2F2F2', },
}
-- stylua: ignore end

local base = {
    bg = '#1a1a1a', -- Main background
    fg = '#e0e0e0', -- Main text

    style = palettes.vivid,
    style_mode = palettes.pastel,
}

local theme = {
    bg = base.bg,
    bg_alt = lighten(base.bg, 3),
    fg = lighten(base.fg, 30),
    fg_dim = darken(base.fg, 40),

    red = base.style.red,
    orange = base.style.orange,
    yellow = base.style.yellow,
    green = base.style.green,
    blue = base.style.blue,
    purple = base.style.purple,
    cyan = base.style.cyan,
    magenta = base.style.magenta,
    pink = base.style.pink,
    gray = base.style.gray,
    black = base.style.black,
    white = base.style.white,

    border = '#404040',
    selection = '#3a3a3a',
    cursor_line = lighten(base.bg, 3),

    -- status line
    sl_text = lighten(base.fg, 40),
    active_buffer = lighten(base.fg, 25),

    mode = base.style_mode,

    -- Diagnostics
    error = palettes.retro.red,
    warn = palettes.retro.yellow,
    info = palettes.retro.cyan,
    hint = palettes.retro.green,
}

hl(0, 'Normal', { fg = theme.fg, bg = theme.bg })
hl(0, 'NormalFloat', { fg = theme.fg, bg = theme.bg_alt })
hl(0, 'LineNr', { fg = theme.fg_dim })
hl(0, 'CursorLine', { bg = theme.cursor_line })
hl(0, 'CursorLineNr', { fg = theme.yellow })
hl(0, 'Visual', { bg = theme.selection })
hl(0, 'Search', { fg = theme.bg, bg = theme.yellow })
hl(0, 'IncSearch', { fg = theme.bg, bg = theme.orange })

hl(0, 'WinSeparator', { fg = theme.purple })
hl(0, 'VertSplit', { fg = theme.purple })
hl(0, 'SignColumn', { fg = theme.red, bg = 'NONE' })

hl(0, 'StatusLine', { fg = theme.sl_text, bg = theme.bg_alt })
hl(0, 'StatusLineNC', { fg = theme.fg_dim, bg = theme.bg_alt })
hl(0, 'StatuslineLSP', { fg = theme.sl_text, bg = 'NONE' })
hl(0, 'StatuslineNormal', { fg = theme.active_buffer, bg = 'NONE', bold = true })
hl(0, 'StatuslineInactive', { fg = darken(theme.active_buffer, 30), bg = 'NONE' })

hl(0, 'Pmenu', { fg = theme.fg, bg = theme.bg_alt })
hl(0, 'PmenuSel', { fg = theme.bg, bg = theme.blue })
hl(0, 'PmenuSbar', { bg = theme.bg_alt })
hl(0, 'PmenuThumb', { bg = theme.fg_dim })

hl(0, 'StatuslineDiagError', { fg = theme.error, bg = 'NONE' })
hl(0, 'StatuslineDiagWarn', { fg = theme.warn, bg = 'NONE' })
hl(0, 'StatuslineDiagInfo', { fg = theme.info, bg = 'NONE' })
hl(0, 'StatuslineDiagHint', { fg = theme.hint, bg = 'NONE' })
hl(0, 'DiagnosticError', { fg = darken(theme.error, 40) })
hl(0, 'DiagnosticWarn', { fg = darken(theme.warn, 40) })
hl(0, 'DiagnosticInfo', { fg = darken(theme.info, 40) })
hl(0, 'DiagnosticHint', { fg = darken(theme.hint, 40) })
hl(0, 'ErrorMsg', { fg = theme.error })
hl(0, 'WarningMsg', { fg = theme.warn })
hl(0, 'Question', { fg = theme.blue })
hl(0, 'MoreMsg', { fg = theme.green })

hl(0, 'StatuslineGit', { fg = theme.cyan, bg = 'NONE', bold = true })
hl(0, 'GitSignsAdd', { fg = theme.green, bg = 'NONE' })
hl(0, 'GitSignsChange', { fg = theme.orange, bg = 'NONE' })
hl(0, 'GitSignsDelete', { fg = theme.red, bg = 'NONE' })

hl(0, 'StatusLineDiffAdd', { fg = lighten(theme.green, 15), bg = 'NONE', bold = true })
hl(0, 'StatuslineDiffMod', { fg = lighten(theme.yellow, 15), bg = 'NONE', bold = true })
hl(0, 'StatuslineDiffDel', { fg = lighten(theme.red, 15), bg = 'NONE', bold = true })

hl(0, 'DiffAdd', { bg = lighten(theme.green, 60) })
hl(0, 'DiffChange', { bg = lighten(theme.yellow, 65) })
hl(0, 'DiffDelete', { bg = lighten(theme.red, 60) })
hl(0, 'DiffText', { bg = lighten(theme.blue, 55) })

-- Treesitter
-- hl(0, '@function', { fg = theme.cyan })
-- hl(0, '@string', { fg = theme.green })
-- hl(0, '@comment', { fg = darken(theme.fg_dim, 20) })
-- hl(0, '@type', { fg = theme.blue })
-- hl(0, '@operator', { fg = theme.red })
-- hl(0, '@punctuation', { fg = theme.fg })
-- hl(0, '@tag', { fg = theme.red })
-- hl(0, '@attribute', { fg = theme.yellow })
-- hl(0, '@number', { fg = theme.purple })
-- hl(0, '@boolean', { fg = theme.orange })
-- hl(0, '@constant', { fg = theme.purple })
-- hl(0, '@variable', { fg = theme.fg })
-- hl(0, '@property', { fg = theme.cyan })
-- hl(0, '@keyword', { fg = theme.fg_dim })

-- Functions & identifiers
-- hl(0, '@function', { fg = theme.cyan })
-- hl(0, '@variable', { fg = theme.fg })
-- hl(0, '@property', { fg = theme.cyan })
-- hl(0, '@string', { fg = theme.green })
-- hl(0, '@number', { fg = theme.purple })
-- hl(0, '@boolean', { fg = theme.orange })
-- hl(0, '@constant', { fg = theme.purple })
-- hl(0, '@type', { fg = theme.blue })
-- hl(0, '@tag', { fg = theme.red })
-- hl(0, '@attribute', { fg = theme.yellow })
-- hl(0, '@keyword', { fg = theme.fg_dim })
-- hl(0, '@operator', { fg = theme.red })
-- hl(0, '@punctuation', { fg = theme.fg })
-- hl(0, '@comment', { fg = darken(theme.fg_dim, 20) })

-- Functions & identifiers
-- hl(0, '@function', { fg = theme.cyan })
-- hl(0, '@variable', { fg = theme.fg })
-- hl(0, '@property', { fg = theme.cyan })
-- hl(0, '@string', { fg = theme.green })
-- hl(0, '@number', { fg = theme.purple })
-- hl(0, '@boolean', { fg = theme.orange })
-- hl(0, '@constant', { fg = theme.purple })
-- hl(0, '@type', { fg = theme.blue })
-- hl(0, '@tag', { fg = theme.red })
-- hl(0, '@attribute', { fg = theme.yellow })
-- hl(0, '@keyword', { fg = theme.red, bold = true })
-- hl(0, '@operator', { fg = theme.fg_dim })
-- hl(0, '@punctuation', { fg = theme.fg })
-- hl(0, '@comment', { fg = darken(theme.fg_dim, 20) })

-- identifiers
hl(0, '@keyword', { fg = theme.yellow, bold = true }) -- generic // debugging
-- hl(0, '@keyword', { fg = theme.fg_dim, bold = true }) -- generic
hl(0, '@keyword.conditional', { fg = theme.red, bold = true }) -- if, else
hl(0, '@keyword.repeat', { fg = theme.red, bold = true }) -- for, while
hl(0, '@keyword.return', { fg = theme.red, bold = true }) -- return
hl(0, '@keyword.coroutine', { fg = theme.red, bold = true }) -- async, await

-- hl(0, 'DiagnosticUnnecessary', { fg = darken(theme.fg_dim, 15), sp = darken(theme.fg_dim, 25), strikethrough = true })
-- hl(0, 'DiagnosticUnnecessary', { fg = darken(theme.fg_dim, 15), strikethrough = true })

---------------------------------------------------------

hl(0, '@variable', { fg = theme.fg })
hl(0, '@variable.parameter', { fg = theme.blue })
-- hl(0, '@variable.builtin', { fg = theme.orange })
-- hl(0, '@variable.member', { fg = theme.orange })
hl(0, '@field', { fg = theme.yellow, italic = true })
hl(0, '@namespace', { fg = theme.yellow })
hl(0, '@module', { fg = theme.yellow })
hl(0, '@function', { fg = theme.cyan })
hl(0, '@method', { fg = theme.cyan })
hl(0, '@constructor', { fg = theme.green })
hl(0, '@type', { fg = theme.blue })
hl(0, '@type.builtin', { fg = lighten(theme.blue, 10) })
hl(0, '@constant', { fg = theme.cyan })
hl(0, '@property', { fg = theme.purple })
hl(0, '@string', { fg = theme.green })
hl(0, '@string.escape', { fg = theme.orange, bold = true })
hl(0, '@number', { fg = theme.purple })
hl(0, '@boolean', { fg = theme.orange })
-- hl(0, '@keyword', { fg = theme.red, bold = true })

-- hl(0, '@keyword.function', { fg = theme.red })
-- hl(0, '@keyword.function', { fg = theme.fg_dim })
-- hl(0, '@keyword.operator', { fg = theme.fg_dim })
-- hl(0, '@keyword.storage', { fg = theme.yellow, bold = true })
hl(0, '@operator', { fg = theme.red })
hl(0, '@punctuation', { fg = theme.fg })
hl(0, '@comment', { fg = darken(theme.fg_dim, 20) })
hl(0, '@tag', { fg = theme.red })
hl(0, '@attribute', { fg = theme.yellow })

-----
hl(0, 'StatuslineModeNormal', { fg = theme.bg, bg = theme.mode.red, bold = true })
hl(0, 'StatuslineModeInsert', { fg = theme.bg, bg = theme.mode.green, bold = true })
hl(0, 'StatuslineModeVisual', { fg = theme.bg, bg = theme.mode.blue, bold = true })
hl(0, 'StatuslineModeVBlock', { fg = theme.bg, bg = theme.mode.blue, bold = true })
hl(0, 'StatuslineModeVLine', { fg = theme.bg, bg = theme.mode.blue, bold = true })
hl(0, 'StatuslineModeCommand', { fg = theme.bg, bg = theme.mode.purple, bold = true })
hl(0, 'StatuslineModePending', { fg = theme.bg, bg = theme.mode.red, bold = true })
hl(0, 'StatuslineModeSelect', { fg = theme.bg, bg = theme.mode.orange, bold = true })
hl(0, 'StatuslineModeSLine', { fg = theme.bg, bg = theme.mode.orange, bold = true })
hl(0, 'StatuslineModeSBlock', { fg = theme.bg, bg = theme.mode.orange, bold = true })
hl(0, 'StatuslineModeICompletion', { fg = theme.bg, bg = theme.mode.yellow, bold = true })
hl(0, 'StatuslineModeReplace', { fg = theme.bg, bg = theme.mode.purple, bold = true })
hl(0, 'StatuslineModeVReplace', { fg = theme.bg, bg = theme.mode.purple, bold = true })
hl(0, 'StatuslineModeCvEx', { fg = theme.bg, bg = theme.mode.red, bold = true })
hl(0, 'StatuslineModeCeEx', { fg = theme.bg, bg = theme.mode.red, bold = true })
hl(0, 'StatuslineModeReplace2', { fg = theme.bg, bg = theme.mode.cyan, bold = true })
hl(0, 'StatuslineModeMore', { fg = theme.bg, bg = theme.mode.cyan, bold = true })
hl(0, 'StatuslineModeConfirm', { fg = theme.bg, bg = theme.mode.cyan, bold = true })
hl(0, 'StatuslineModeShell', { fg = theme.bg, bg = theme.mode.red, bold = true })
hl(0, 'StatuslineModeTerminal', { fg = theme.bg, bg = theme.mode.red, bold = true })

hl(0, 'StatuslineModeNormalSep', { fg = theme.mode.red, bg = 'NONE' })
hl(0, 'StatuslineModeInsertSep', { fg = theme.mode.green, bg = 'NONE' })
hl(0, 'StatuslineModeVisualSep', { fg = theme.mode.blue, bg = 'NONE' })
hl(0, 'StatuslineModeVBlockSep', { fg = theme.mode.blue, bg = 'NONE' })
hl(0, 'StatuslineModeVLineSep', { fg = theme.mode.blue, bg = 'NONE' })
hl(0, 'StatuslineModeCommandSep', { fg = theme.mode.purple, bg = 'NONE' })
hl(0, 'StatuslineModePendingSep', { fg = theme.mode.red, bg = 'NONE' })
hl(0, 'StatuslineModeSelectSep', { fg = theme.mode.orange, bg = 'NONE' })
hl(0, 'StatuslineModeSLineSep', { fg = theme.mode.orange, bg = 'NONE' })
hl(0, 'StatuslineModeSBlockSep', { fg = theme.mode.orange, bg = 'NONE' })
hl(0, 'StatuslineModeICompletionSep', { fg = theme.mode.yellow, bg = 'NONE' })
hl(0, 'StatuslineModeReplaceSep', { fg = theme.mode.purple, bg = 'NONE' })
hl(0, 'StatuslineModeVReplaceSep', { fg = theme.mode.purple, bg = 'NONE' })
hl(0, 'StatuslineModeCvExSep', { fg = theme.mode.red, bg = 'NONE' })
hl(0, 'StatuslineModeCeExSep', { fg = theme.mode.red, bg = 'NONE' })
hl(0, 'StatuslineModeReplace2Sep', { fg = theme.mode.cyan, bg = 'NONE' })
hl(0, 'StatuslineModeMoreSep', { fg = theme.mode.cyan, bg = 'NONE' })
hl(0, 'StatuslineModeConfirmSep', { fg = theme.mode.cyan, bg = 'NONE' })
hl(0, 'StatuslineModeShellSep', { fg = theme.mode.red, bg = 'NONE' })
hl(0, 'StatuslineModeTerminalSep', { fg = theme.mode.red, bg = 'NONE' })
