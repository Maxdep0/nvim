local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end
vim.g.mapleader = ' '

--------------------------------------------------------
--                     Disabled Keys                  --
--------------------------------------------------------
map('n', 'u', '<Nop>', 'Disabled: Use <C-z> instead')
map('i', '<C-u>', '<Nopp>', 'Disabled: Use <C-z> instead')
map({ 'n', 'i' }, '<C-r>', '<Nop>', 'Disabled: Use <C-y> instead')
map('n', 'ZQ', '<Nop>', 'Disabled')
map('n', 'ZZ', '<Nop>', 'Disabled')
map('n', 'C', '<Nop>', 'Disabled')
map('n', 'gQ', '<Nop>', 'Disabled')

--------------------------------------------------------
--                     Basic Operations               --
--------------------------------------------------------

map('n', '<Esc>', ':nohlsearch<CR>', 'Keymap: Toggle off hlsearch')
map('n', '<C-a>', 'gg<S-v>G', 'Keymap: Select the entire file')
map('n', 'j', 'gj', 'Keymap: Navigate through wrapped lines')
map('n', 'k', 'gk', 'Keymap: Navigate through wrapped lines')
map('i', '<C-l>', '<CR>', 'Keymap: Same as enter key')

--------------------------------------------------------
--                     Special Keymaps               --
--------------------------------------------------------

map('n', '<F1>', ':lua toggle_float_hover()<CR>', 'SPECIAL: Toggle float on hover')
map('n', '<F2>', ':lua toggle_document_highlight()<CR>', 'SPECIAL: Toggle document highlights')
map('n', '<F4>', ':lua toggle_transparency()<CR>', 'SPECIAL: Toggle transparent background')
map('n', 'ZZ', ':lua save_and_close_current_buffer()<CR>', 'Save and close current buffer') --   :w | bd

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

vim.keymap.set('n', '<leader>;u', ':.,0s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { noremap = true })
vim.keymap.set('n', '<leader>;d', ':.,$s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { noremap = true })
vim.keymap.set('n', '<leader>;', ':s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', { noremap = true })

--------------------------------------------------------
--                     Movement                       --
--------------------------------------------------------

map('n', '<C-d>', '<C-d>zz', 'Keymap: Move down 1/2 page and center cursor')
map('n', '<C-u>', '<C-u>zz', 'Keymap: Move up 1/2 page and center cursor')
map({ 'n', 'v' }, '<leader>l', '$', 'Keymap: Jump to the end of the line')
map({ 'n', 'v' }, '<leader>h', '0', 'Keymap: Jump to the start of the line')

--------------------------------------------------------
--                  LSP/DIAGNOSTIC                    --
--------------------------------------------------------

map('n', 'gd', vim.lsp.buf.definition, 'LSP: Goto definition')
map('n', 'gI', vim.lsp.buf.implementation, 'LSP: Goto implementation')
map('n', 'K', vim.lsp.buf.hover, 'LSP: Hover Documentation')
map('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Diagnostic: Go to previous diagnostic')
map('n', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Diagnostic: Go to next diagnostic')

--------------------------------------------------------
--                     Navigation                     --
--------------------------------------------------------

map('n', '<leader>ft', vim.cmd.Ex, 'Keymap: Open netrw file tree')
map('n', '<C-j>', ':bp<CR>', 'Keymap: Go to the previous buffer')
map('n', '<C-k>', ':bn<CR>', 'Keymap: Go to the next buffer')
map('n', 'n', 'nzzzv', 'Keymap: Repeat search in same direction and center cursor')
map('n', 'N', 'Nzzzv', 'Keymap: Repeat search in opposite direction and center cursor')

--------------------------------------------------------
--              Clipboard and Registers               --
--------------------------------------------------------

-- Yank
map('n', 'y', '"+y', 'Operator: Yank to system clipboard (combine with motion)')
map('n', 'Y', '"+Y', 'Keymap: Yank whole line to system clipboard')
map('v', 'y', '"+y', 'Keymap: Yank selected text to system clipboard')

-- Paste
map('n', 'p', '"+P', 'Operator: Paste from system clipboard')
map('v', 'p', '"_d"+P', 'Keymap: Replace selected text with system clipboard')

-- Delete
map('n', 'd', '"_d', 'Operator: Delete without register change (combine with motion)')
map('n', 'D', '"_D', 'Keymap: Delete to end of line without changing clipboard')
map('v', 'd', '"_d', 'Keymap: Delete selected text without changing clipboard')

map('n', '<leader>d', '"+d', 'Operator: Delete and yank to system clipboard (combine with motion)')
map('n', '<leader>D', '"+D', 'Keymap: Delete to end of line and yank to system clipboard')
map('v', '<leader>d', '"+d', 'Keymap: Delete selected text and yank to system clipboard')
map('v', '<leader>D', '"+D', 'Keymap: Delete whole line and yank to system clipboard')

map('n', 'x', '"_x', 'Keymap: Cut character without changing clipboard')
map('v', 'x', '"_x', 'Keymap: Cut character without changing clipboard')

-- Change
map('n', 'c', '"_c', 'Operator: Change without register change (combine with motion)')
map('n', 'C', '"_C', 'Keymap: Change to end of line without changing clipboard')
map('v', 'c', '"_c', 'Keymap: Change selected text without changing clipboard')
map('v', 'C', '"_C', 'Keymap: Change selected text without changing clipboard')

-- stylua: ignore end
