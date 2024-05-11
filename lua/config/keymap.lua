local m = vim.keymap.set
local o = { noremap = true, silent = true }

vim.g.mapleader = ' '

m('n', 'u', '<nop>')
m('n', '<C-r>', '<nop>')
m('n', 'ZQ', '<nop>')
--
m('n', '<leader>pv', vim.cmd.Ex) -- Open neovim file tree
m('n', ';', ':') -- ; same as :
--
m({ 'n', 'v', 'i' }, '<C-s>', '<Esc>:w<CR>', o) -- Save
m('n', '<C-z>', ':undo<CR>') -- Undo
m('n', '<C-y>', ':redo<CR>') -- Redo
--
m('n', '<Esc>', ':nohlsearch<CR>', o) -- Toggle off hlsearch
--
m('n', '<Tab>', 'gt') -- Focus next tab
m('n', '<S-Tab>', 'gT') -- Focus prev tab
m('n', '<C-j>', ':bp<CR>') -- Go to the prev buffer
m('n', '<C-k>', ':bn<CR>') -- Go to the next buffer
m('n', '<C-h>', '<C-w>h') -- Focus prev window
m('n', '<C-l>', '<C-w>l') -- Focus next window
--
m('v', '<C-j>', ":m '>+1<CR>gv=gv", o) -- Move line down
m('v', '<C-k>', ":m '<-2<CR>gv=gv", o) -- Move line up
--
m('v', '<Tab>', '"9Y"9[pgv', o) -- Duplicate
--
m('n', 'J', 'mzJ`z', o) -- Join line below without change cursor position
--
m('n', '<C-d>', '<C-d>zz', o) -- Move down 1/2 page and center cursor
m('n', '<C-u>', '<C-u>zz', o) -- Move up 1/2 page and center cursor
m('n', 'n', 'nzzzv', o) -- Centered cursor during search
m('n', 'N', 'Nzzzv', o) -- Centered cursor during search
--
m('n', '<C-a>', 'gg<S-v>G') -- Select the entire file
m({ 'n', 'v' }, 'y', '"+y', o) -- Yank to system clipboard
m({ 'n', 'v' }, '<leader>y', '"1y', o) -- Yand to reg 1
m('n', 'Y', '"+Y', o) -- Yank to system clipboard
m('n', '<leader>Y', '"1Y', o) -- Yank to reg 1
--
m('n', 'p', '"+P', o) -- Paste from system clipboard
m('n', '<leader>p', '"1P', o) -- Paste from reg 1
m('v', 'P', '"_d"+P', o) -- Paste from system clipboard w/o reg change
m('v', '<leader>p', '"_d"1P', o) -- Paste from reg 1
--
m({ 'n', 'v' }, 'd', '"_d', o) -- Delete w/o reg change
m({ 'n', 'v' }, '<leader>d', '"+d', o) -- delete and yank it to system reg

m({ 'n', 'v' }, 'x', '"_x', o) -- Delete character w/o reg change
m({ 'n', 'v' }, '<leader>x', '"+x', o) -- Cut character and yank it to system reg

m({ 'n', 'v' }, 'D', '"_D', o)
m({ 'n', 'v' }, '<leader>D', '"+D', o) -- delete and yank it to system reg
--
m({ 'n', 'v' }, '<leader>l', '$', o) -- Jump to the end of the line
m({ 'n', 'v' }, '<leader>h', '0', o) -- Jump the the start of the line
