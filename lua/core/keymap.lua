-- stylua: ignore start
local map = function(mode, lhs, rhs, desc, opts)
    opts = vim.tbl_extend('force', { noremap = true, silent = true, desc = desc }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

vim.g.mapleader = ' '

--------------------------------------------------------
--                     Disabled Keys                  --
--------------------------------------------------------
map('n', 'u', '<Nop>', 'Disabled')
map('i', '<C-u>', '<Nopp>', 'Disabled')
map({ 'n', 'i' }, '<C-r>', '<Nop>', 'Disabled')
map('n', 'ZQ', '<Nop>', 'Disabled')
map('n', 'ZZ', '<Nop>', 'Disabled')
map('n', 'C', '<Nop>', 'Disabled')
map('n', 'gQ', '<Nop>', 'Disabled')

--------------------------------------------------------
--                     Basic Operations               --
--------------------------------------------------------

map('n', '<Esc>', ':nohlsearch<CR>', 'Toggle off hlsearch')
map('n', '<C-a>', 'gg<S-v>G', 'Select the entire file')
map('n', 'j', 'gj', 'Navigate through wrapped lines')
map('n', 'k', 'gk', 'Navigate through wrapped lines')
map('i', '<C-l>', '<CR>', 'Same as enter key')

--------------------------------------------------------
--                     Special Keymaps               --
--------------------------------------------------------

map('n', '<F1>', ':lua toggle_float_hover()<CR>', 'Toggle float on hover')
map('n', '<F2>', ':lua toggle_document_highlight()<CR>', 'Toggle document highlights')
map('n', '<F4>', ':lua toggle_transparency()<CR>', 'Toggle transparent background')

--------------------------------------------------------
--                     Editing                        --
--------------------------------------------------------

map('n', 'ZZ', ':w | bd<CR>', 'Save and close current buffer')
map({ 'n', 'v', 'i' }, '<C-s>', '<Esc>:w<CR>', 'Save file')
map('n', '<C-z>', ':undo<CR>', 'Undo')
map('n', '<C-y>', ':redo<CR>', 'Redo')
map('v', '<C-j>', ":m '>+1<CR>gv=gv", 'Move line down')
map('v', '<C-k>', ":m '<-2<CR>gv=gv", 'Move line up')
map('v', '<Tab>', '"9Y"9[pgv', 'Duplicate selected lines')
map('n', 'J', 'mzJ`z', 'Join line below without changing cursor position')

map('n', '<leader>;u', ':.,0s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', 'Select word under the cursor and edit all above', { noremap = true, silent = false })
map('n', '<leader>;d', ':.,$s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', 'Select word under the cursor and edit all below', { noremap = true, silent = false })
map('n', '<leader>;', ':s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', 'Select word under the cursor and edit all in buffer', { noremap = true, silent = false })

--------------------------------------------------------
--                     Movement                       --
--------------------------------------------------------

map('n', '<C-d>', '<C-d>zz', 'Move down 1/2 page and center cursor')
map('n', '<C-u>', '<C-u>zz', 'Move up 1/2 page and center cursor')
map({ 'n', 'v' }, '<leader>l', '$', 'Jump to the end of the line')
map({ 'n', 'v' }, '<leader>h', '0', 'Jump to the start of the line')

--------------------------------------------------------
--                  LSP/DIAGNOSTIC                    --
--------------------------------------------------------

map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
map('n', 'gI', vim.lsp.buf.implementation, 'Go to implementation')
map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
map('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Go to previous diagnostic')
map('n', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Go to next diagnostic')

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

-- Yank
map('n', 'y', '"+y', 'Yank to system clipboard (combine with motion)')
map('n', 'Y', '"+Y', 'Yank whole line to system clipboard')
map('v', 'y', '"+y', 'Yank selected text to system clipboard')

-- Paste
map('n', 'p', '"+P', 'Paste from system clipboard')
map('v', 'p', '"_d"+P', 'Replace selected text with system clipboard')

-- Delete
map('n', 'd', '"_d', 'Delete without register change (combine with motion)')
map('n', 'D', '"_D', 'Delete to end of line without changing clipboard')
map('v', 'd', '"_d', 'Delete selected text without changing clipboard')

map('n', '<leader>d', '"+d', 'Delete and yank to system clipboard (combine with motion)')
map('n', '<leader>D', '"+D', 'Delete to end of line and yank to system clipboard')
map('v', '<leader>d', '"+d', 'Delete selected text and yank to system clipboard')
map('v', '<leader>D', '"+D', 'Delete whole line and yank to system clipboard')

map('n', 'x', '"_x', 'Cut character without changing clipboard')
map('v', 'x', '"_x', 'Cut character without changing clipboard')

-- Change
map('n', 'c', '"_c', 'Change without register change (combine with motion)')
map('n', 'C', '"_C', 'Change to end of line without changing clipboard')
map('v', 'c', '"_c', 'Change selected text without changing clipboard')
map('v', 'C', '"_C', 'Change selected text without changing clipboard')

-- stylua: ignore end
