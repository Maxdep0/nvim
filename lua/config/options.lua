local o = vim.opt
local g = vim.g

g.loaded_tutor_mode_plugin = 1

-- g.netrw_keepdir = 0
g.netrw_banner = 0

o.mouse = 'a'
o.clipboard = 'unnamedplus'
o.backspace = 'indent,start,eol'
o.completeopt = 'menuone,noinsert,noselect'
o.relativenumber = true

o.number = true
o.splitright = true
o.splitbelow = true
o.linebreak = true
o.termguicolors = true
o.laststatus = 3
o.wrap = true
o.colorcolumn = ''
o.cursorline = true

o.inccommand = 'split'

o.signcolumn = 'yes'
o.scrolloff = 5

o.ignorecase = true
o.hlsearch = true
o.incsearch = true
o.showmatch = true

o.expandtab = true
o.smartindent = true
o.softtabstop = 4
o.shiftwidth = 4
o.tabstop = 4

o.hidden = true
o.history = 100
--o.lazyredraw = true
o.synmaxcol = 500
o.updatetime = 250

o.swapfile = false
o.backup = false
-- o.undodir = vim.fn.getcwd() .. '/cache/undir'
o.undofile = true

o.shortmess = 'sI'

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
    desc = 'Hightlight selection on yank',
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 500 })
    end,
})
