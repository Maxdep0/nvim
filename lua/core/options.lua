local o = vim.o

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
o.wrap = false
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
o.lazyredraw = false -- true
o.ttyfast = true
o.synmaxcol = 750 --- 250
o.updatetime = 200
o.timeoutlen = 400

o.redrawtime = 10000 --
o.regexpengine = 0 --

o.swapfile = false
o.backup = false
o.undofile = true

o.shortmess = 'sI'

local g = vim.g

g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

g.loaded_2html_plugin = 1
g.loaded_zipPlugin = 1
g.loaded_gzip = 1
g.loaded_tarPlugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_sql_completion = 1

vim.opt.fillchars:append({ vert = '┃' })

-- g.netrw_keepdir = 0
g.netrw_banner = 0

vim.filetype.add({
    filename = {
        ['.aliasrc'] = 'zsh',
        ['.zshenv'] = 'zsh',
        ['.zprofile'] = 'zsh',
    },
    extension = {
        zsh = 'zsh',
    },
})
