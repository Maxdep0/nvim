-- stylua: ignore start
local toggles = require('core.toggles')
local utils = require('core.utils')

local map = utils.map


vim.g.mapleader = ' '

--------------------------------------------------------
--                     Disabled Keys                  --
--------------------------------------------------------
map('n', 'u', '<Nop>', 'Disabled')
map('i', '<C-u>', '<Nop>', 'Disabled')
map( 'n',  '<C-r>', '<Nop>', 'Disabled')
map('n', 'ZQ', '<Nop>', 'Disabled')
map('n', 'ZZ', '<Nop>', 'Disabled')
map('n', 'gQ', '<Nop>', 'Disabled')

--------------------------------------------------------
--                     Basic Operations               --
--------------------------------------------------------

map('n', '<Esc>', ':nohlsearch<CR>:lua vim.snippet.stop()<CR>', 'Toggle off highlights')
map('n', '<C-a>', 'gg<S-v>G', 'Select the entire file')
map('n', 'j', 'gj', 'Navigate through wrapped lines')
map('n', 'k', 'gk', 'Navigate through wrapped lines')
map('i', '<C-l>', '<CR>', 'Same as enter key')
map('t', '<esc>', '<C-\\><C-n>')


--------------------------------------------------------
--                     Special Keymaps               --
--------------------------------------------------------

map('n', '<F1>', toggles.toggle_float_hover, 'Toggle float on hover')
map('n', '<F4>', toggles.toggle_transparency, 'Toggle transparent background')


--------------------------------------------------------
--                     Editing                        --
--------------------------------------------------------

map({ 'n', 'x' }, '<C-s>', '<Esc>:w<CR>', 'Save file')

map('n', '<A-u>', ':undo<CR>', 'Undo')
map('n', '<A-r>', ':redo<CR>', 'Redo')

map('v', '<C-j>', ":<C-u>silent! '<,'>move '>+1<CR>gv=gv", 'Move selection down' )
map('v', '<C-k>', ":<C-u>silent! '<,'>move '<-2<CR>gv=gv", 'Move selection up' )

map('v', '<Tab>', '"9Y"9[pgv', 'Duplicate selected lines')
map('n', 'J', 'mzJ`z', 'Join line below without changing cursor position')


map('n', '<leader>/u', ':.,0s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', 'Select word under the cursor and edit all above', { noremap = true, silent = false })
map('n', '<leader>/d', ':.,$s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', 'Select word under the cursor and edit all below', { noremap = true, silent = false })
map('n', '<leader>/', ':s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', 'Select word under the cursor and edit all in buffer', { noremap = true, silent = false })

--------------------------------------------------------
--                     Movement                       --
--------------------------------------------------------

map('n', '<C-d>', '<C-d>zz', 'Move down 1/2 page and center cursor')
map('n', '<C-u>', '<C-u>zz', 'Move up 1/2 page and center cursor')
map({ 'n', 'v' }, '<leader>l', '$', 'Jump to the end of the line')
map({ 'n', 'v' }, '<leader>h', '0', 'Jump to the start of the line')
map('n', '<C-.>', '<C-w>>', '...')
map('n', '<C-,>', '<C-w><', '...')
map('n', '<leader><C-Cr>', '<C-w>c', '...')

--------------------------------------------------------
--                     Windows                        --
--------------------------------------------------------

map('n', '<A-CR>', '<C-w>v', 'Open new window')
map('n', '<A-S-Q>', '<C-w>c', 'Close current window')

map('n', '<A-h>', '<C-w>h', 'Move focus left')
map('n', '<A-l>', '<C-w>l', 'Move focus right window')
map('n', '<A-j>', '<C-w>j', 'Move focus up')
map('n', '<A-k>', '<C-w>k', 'Move focus down')

map('n', '<A-S-h>', '<C-w>H', 'Move window left')
map('n', '<A-S-l>', '<C-w>L', 'Move window right')
map('n', '<A-S-k>', '<C-w>K', 'Move window up')
map('n', '<A-S-j>', '<C-w>J', 'Move window down')


map('n', 'ZZ', utils.delete_buffer_and_keep_window_open, 'Delete buffer and keep window open')
map('n', '<A-C-h>', function() utils.resize_window('left') end, 'Move divider left')
map('n', '<A-C-l>', function() utils.resize_window('right') end, 'Move divider right')
map('n', '<A-C-k>', function() utils.resize_window('up') end, 'Move divider up')
map('n', '<A-C-j>', function() utils.resize_window('down') end, 'Move divider down')
map('n', '<A-c>', toggles.toggle_windows_layout, 'Toggle horizontal/vertical layout')

-- ------------------------------------------------------
--                  LSP/DIAGNOSTIC                     --
-- ------------------------------------------------------
--
map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')

--------------------------------------------------------
--                     Navigation                     --
--------------------------------------------------------

map('n', '<leader>ft', vim.cmd.Ex, 'Open netrw file tree')
map('n', '<C-j>', ':bp<CR>', 'Go to the previous buffer')
map('n', '<C-k>', ':bn<CR>', 'Go to the next buffer')
map('n', 'n', 'nzzzv', 'Repeat search in same direction and center cursor')
map('n', 'N', 'Nzzzv', 'Repeat search in opposite direction and center cursor')

--------------------------------------------------------
--              Clipboard and Registers               --
--------------------------------------------------------

map('n', 'YY', "m'0_yg_``", 'Yank line content (no indent, no trailing spaces, no newline)')

map({'n', 'x'}, 'd', '"_d', 'Delete motion  (preserve clipboard)')
map({'n', 'x'}, 'D', '"_D', 'Delete to end of line (preserve clipboard)')

map({'n', 'x'}, '<leader>d', '"+d', 'Delete motion and copy to system clipboard')
map({'n', 'x'}, '<leader>D', '"+D', 'Delete to end of line and copy to system clipboard')

map('n', 'x', '"_x', 'Delete single char (preserve clipboard)')

map({'n', 'x'}, 'c', '"_c', 'Changewithout register change (combine with motion)')
map({'n', 'x'}, 'C', '"_C', 'Change selected text (preserve clipboard)')
