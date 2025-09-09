vim.cmd('hi clear')
if vim.fn.exists('syntax_on') == 1 then vim.cmd('syntax reset') end

vim.g.colors_name = 'base16-maxik'

local u = require('core.utils')
local lighten, darken = u.lighten, u.darken
local hl = vim.api.nvim_set_hl

if vim.fn.has('termguicolors') == 1 then vim.o.termguicolors = true end

local base00 = '#1A1A1A'
local base01 = '#242424'
local base02 = '#353535'
local base03 = '#4A4A4A'
local base04 = '#B8B8B8'
local base05 = '#D8D8D8'
local base06 = '#E8E8E8'
local base07 = '#FFFFFF'

local base08 = '#CC6666'
local base09 = '#DC9656'
local base0E = '#BA8BAF'
local base0F = '#A16946'
local base0A = '#F0C674'
local base0B = '#98C379'
local base0C = '#8ABEB6'
local base0D = '#81A2BE'

local theme = {
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
    },
}


-- stylua: ignore start

hl(0, 'Normal',                 { bg = base00, fg = base05 })
hl(0, 'LineNr',                 { bg = base00, fg = base03 })
hl(0, 'CursorLineNr',           { bg = base01, fg = lighten(base03, 30) })
hl(0, 'Visual',                 { bg = base02              })
hl(0, 'Search',                 { bg = base0A, fg = base00 })
hl(0, 'IncSearch',              { bg = base07, fg = base00 })

hl(0, 'NormalFloat',            { bg = base01, fg = base05 })
hl(0, 'FloatBorder',            {              fg = base02 })
hl(0, 'FloatTitle',             {              fg = base06, bold = true })

hl(0, 'WinSeparator',           {              fg = base02 })
hl(0, 'VertSplit',              {              fg = base02 })
hl(0, 'SignColumn',             { bg = base00, fg = base03 })

hl(0, 'StatusLine',             { bg = base01, fg = base04 })
hl(0, 'StatusLineNC',           { bg = base01, fg = base03 })

hl(0, 'Pmenu',                  { bg = base01, fg = base05 })
hl(0, 'PmenuSel',               { bg = base02, fg = base06 })
hl(0, 'PmenuSbar',              { bg = base02              })
hl(0, 'PmenuThumb',             { bg = base04              })

hl(0, 'DiagnosticError',        {              fg = base08, bold = true })
hl(0, 'DiagnosticWarn',         {              fg = base09, bold = true })
hl(0, 'DiagnosticInfo',         {              fg = base0B, bold = true })
hl(0, 'DiagnosticHint',         {              fg = base0C, bold = true })

hl(0, 'ErrorMsg',               {              fg = base08 })
hl(0, 'WarningMsg',             {              fg = base09 })
hl(0, 'Question',               {              fg = base0D })
hl(0, 'MoreMsg',                {              fg = base0B })

hl(0, 'DiffAdd',                {              fg = base0B })
hl(0, 'DiffChange',             {              fg = base09 })
hl(0, 'DiffDelete',             {              fg = base08 })
hl(0, 'DiffText',               {              fg = base0A })

hl(0, 'GitSignsAdd',           {               fg = darken(base0B, 30) })
hl(0, 'GitSignsChange',        {               fg = darken(base0A, 30) })
hl(0, 'GitSignsDelete',        {               fg = darken(base08, 30) })
hl(0, 'GitSignsTopdelete',     {               fg = darken(base08, 30) })
hl(0, 'GitSignsChangedelete',  {               fg = darken(base0F, 30) })
hl(0, 'GitSignsUntracked',     {               fg = base0C })

hl(0, '@variable',              {              fg = base04 })
hl(0, '@variable.member',       {              fg = darken(base04, 10) })

hl(0, '@constant',              {              fg = base08, bold = true })
hl(0, '@module',                {              fg = base05 })
hl(0, '@label',                 {              fg = base0A })
hl(0, '@string',                {              fg = base0B })
hl(0, '@character',             {              fg = base09 })
hl(0, '@boolean',               {              fg = base08, bold = true })
hl(0, '@number',                {              fg = base09, bold = true })
hl(0, '@type',                  {              fg = darken(base0A, 10) })
hl(0, '@attribute',             {              fg = base0C })
hl(0, '@property',              {              fg = base04 })
hl(0, '@function',              {              fg = base0D, bold = true })
hl(0, '@constructor',           {              fg = base0A, bold = true})
hl(0, '@operator',              {              fg = base05, bold = true })

hl(0, '@keyword',               {              fg = darken(base0E, 50) })
hl(0, '@keyword.coroutine',     {              fg = base0E })
hl(0, '@keyword.function',      {              fg = base0E, bold = true})
hl(0, '@keyword.conditional',   {              fg = base0E})
hl(0, '@keyword.repeat',        {              fg = base0E, bold = true })
hl(0, '@keyword.return',        {              fg = base0E })
hl(0, '@keyword.import',        { link = '@keyword' })
hl(0, '@keyword.operator',      {              fg = base0E,             italic = true })
hl(0, '@keyword.exception',     {              fg = base0E,             italic = true })

hl(0, '@punctuation',           {              fg = base05 })
hl(0, '@comment',               {              fg = base03 })
hl(0, '@comment.todo',          { link = 'DiagnosticHint' })  -- TODO, WIP
hl(0, '@comment.note',          { link = 'DiagnosticInfo' })  -- NOTE, INFO
hl(0, '@comment.error',         { link = 'DiagnosticError' }) -- ERROR, FIXME
hl(0, '@comment.warning',       { link = 'DiagnosticWarn' })  -- WARNING, HACK
hl(0, 'DiagnosticUnnecessary',  {              fg = darken(base04, 40) })

hl(0, "@lsp.type.comment.lua",  { link = "" })
hl(0, '@keyword.vim',           { link = '' })

vim.g.base00 = base00
vim.g.base01 = base01
vim.g.base02 = base02
vim.g.base03 = base03
vim.g.base04 = base04
vim.g.base05 = base05
vim.g.base06 = base06
vim.g.base07 = base07
vim.g.base08 = base08
vim.g.base09 = base09
vim.g.base0A = base0A
vim.g.base0B = base0B
vim.g.base0C = base0C
vim.g.base0D = base0D
vim.g.base0E = base0E
vim.g.base0F = base0F

vim.g.base16_statusline = theme.statusline
