local M = {}

function M.resize_window(direction)
    local cur_win = vim.fn.winnr()

    if direction == 'left' or direction == 'right' then
        local can_move = vim.fn.winnr('h') ~= cur_win or vim.fn.winnr('l') ~= cur_win
        if not can_move then return end

        local last_win = vim.fn.winnr('$')
        if direction == 'left' then
            vim.cmd(cur_win == last_win and 'vertical resize +5' or 'vertical resize -5')
        else
            vim.cmd(cur_win == last_win and 'vertical resize -5' or 'vertical resize +5')
        end
    else
        local can_move = vim.fn.winnr('k') ~= cur_win or vim.fn.winnr('j') ~= cur_win
        if not can_move then return end

        local last_win = vim.fn.winnr('$')
        if direction == 'up' then
            vim.cmd(cur_win == last_win and 'resize +5' or 'resize -5')
        else
            vim.cmd(cur_win == last_win and 'resize -5' or 'resize +5')
        end
    end
end

-- When deleting buffer, keep window open
function M.delete_buffer_and_keep_window_open()
    vim.cmd('write')

    local win_count = vim.fn.winnr('$')

    -- 1 buffer = close buffer and window
    if win_count == 1 then
        vim.cmd('bd')
    else
        local listed_bufs = vim.tbl_filter(
            function(buf) return vim.fn.buflisted(buf) == 1 end,
            vim.api.nvim_list_bufs()
        )

        -- buffers > 1 = close buffer and keep window open
        if #listed_bufs > 1 then
            vim.cmd('bp | bd #')
        else
            vim.cmd('enew | bd #')
        end
    end
end

function M.map(mode, lhs, rhs, desc, opts)
    opts = vim.tbl_extend('force', { noremap = true, silent = true, desc = desc }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

return M
