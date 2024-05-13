local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

vim.g.mapleader = ' '

--------------------------------------------------------
--                     Disabled Keys                  --
--------------------------------------------------------

map('n', 'u', '<nop>', 'Disabled: Use <C-z> instead')
map('n', '<C-r>', '<nop>', 'Disabled: Use <C-y> instead')
map('n', 'ZQ', '<nop>', 'Disabled')

--------------------------------------------------------
--                     Basic Operations               --
--------------------------------------------------------

map('n', '<Esc>', ':nohlsearch<CR>', 'Keymap: Toggle off hlsearch')
map('n', '<C-a>', 'gg<S-v>G', 'Keymap: Select the entire file')
map({ 'n', 'i' }, '<Esc>', '<Esc><Esc>', 'Keymap: Double <Esc>')

--------------------------------------------------------
--                     Special Keymaps               --
--------------------------------------------------------

map('n', '<leader>tt', ':lua toggleTransparent()<CR>', 'Keymap: [T]oggle [T]ransparent Background')

--------------------------------------------------------
--                     Editing                        --
--------------------------------------------------------

map({ 'n', 'v', 'i' }, '<C-s>', '<Esc>:w<CR>', 'Keymap: Save file')
map('n', '<C-z>', ':undo<CR>', 'Keymap: Undo')
map('n', '<C-y>', ':redo<CR>', 'Keymap: Redo')
map('v', '<C-j>', ":m '>+1<CR>gv=gv", 'Keymap: Move line down')
map('v', '<C-k>', ":m '<-2<CR>gv=gv", 'Keymap: Move line up')
map('v', '<Tab>', '"9Y"9[pgv', 'Keymap: Duplicate selected lines')
map('n', 'J', 'mzJ`z', 'Keymap: Join line below without changing cursor position')

--------------------------------------------------------
--                     Movement                       --
--------------------------------------------------------

map('n', '<C-d>', '<C-d>zz', 'Keymap: Move down 1/2 page and center cursor')
map('n', '<C-u>', '<C-u>zz', 'Keymap: Move up 1/2 page and center cursor')
map({ 'n', 'v' }, '<leader>l', '$', 'Keymap: Jump to the end of the line')
map({ 'n', 'v' }, '<leader>h', '0', 'Keymap: Jump to the start of the line')

--------------------------------------------------------
--                     Navigation                     --
--------------------------------------------------------

map('n', '<leader>ft', vim.cmd.Ex, 'Keymap: Open netrw file tree')
map('n', '<C-h>', '<C-w>h', 'Keymap: Focus previous window')
map('n', '<C-l>', '<C-w>l', 'Keymap: Focus next window')
map('n', '<Tab>', 'gt', 'Keymap: Focus next tab')
map('n', '<S-Tab>', 'gT', 'Keymap: Focus previous tab')
map('n', '<C-j>', ':bp<CR>', 'Keymap: Go to the previous buffer')
map('n', '<C-k>', ':bn<CR>', 'Keymap: Go to the next buffer')
map('n', 'n', 'nzzzv', 'Keymap: Repeat search in same direction and center cursor')
map('n', 'N', 'Nzzzv', 'Keymap: Repeat search in opposite direction and center cursor')

--------------------------------------------------------
--                     Clipboard and Registers        --
--------------------------------------------------------

-- System Clipboard
map('n', 'y', '"+y', 'Operator: Yank to system clipboard (combine with motion)')
map('n', 'd', '"_d', 'Operator: Delete without register change (combine with motion)')
map('n', 'p', '"+P', 'Operator: Paste from system clipboard')
map('n', 'Y', '"+Y', 'Keymap: Yank whole line to system clipboard')
map('v', 'y', '"+y', 'Keymap: Yank selected text to system clipboard')
map('v', 'p', '"_d"+P', 'Keymap: Replace selected text with system clipboard without register change')
map('v', 'd', '"_d', 'Keymap: Delete selected text without changing clipboard')
map('n', 'D', '"_D', 'Keymap: Delete to end of line without changing clipboard')
map('n', 'x', '"_x', 'Keymap: Cut character without changing clipboard')
map('v', 'x', '"_x', 'Keymap: Cut character without changing clipboard')

-- Register 1
map('n', '<leader>y', '"1y', 'Operator: Yank to register 1 (combine with motion)')
map('n', '<leader>d', '"+d', 'Operator: Delete and yank to system clipboard (combine with motion)')
map('n', '<leader>p', '"1P', 'Operator: Paste from register 1')
map('v', '<leader>y', '"1y', 'Keymap: Yank selected text to register 1')
map('n', '<leader>Y', '"1Y', 'Keymap: Yank whole line to register 1')
map('v', '<leader>d', '"+d', 'Keymap: Delete selected text and yank to system clipboard')
map('n', '<leader>D', '"+D', 'Keymap: Delete to end of line and yank to system clipboard')
map('v', '<leader>D', '"+D', 'Keymap: Delete whole line and yank to system clipboard')
map('v', '<leader>p', '"_d"1P', 'Keymap: Replace selected text with register 1 without register change')
map('n', '<leader>x', '"+x', 'Keymap: Cut character and yank to system clipboard')
map('v', '<leader>x', '"+x', 'Keymap: Cut selected text and yank to system clipboard')
