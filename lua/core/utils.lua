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

function M.map(mode, lhs, rhs, desc, opts)
    opts = vim.tbl_extend('force', { noremap = true, silent = true, desc = desc }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

function M.delete_buffer_and_keep_window_open()
    local cur = vim.api.nvim_get_current_buf()
    local cur_bt = vim.bo[cur].buftype

    if cur_bt == '' and vim.api.nvim_buf_get_name(cur) ~= '' and vim.bo[cur].modified then vim.cmd('write') end

    local function real_wins()
        local out = {}
        for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local cfg = vim.api.nvim_win_get_config(w)
            if cfg.relative == '' then table.insert(out, w) end
        end
        return out
    end

    local wins = real_wins()

    if cur_bt ~= '' then
        if #wins <= 1 then
            vim.cmd('quit')
        else
            vim.cmd('close')
        end
        return
    end

    local replacement = nil
    for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if b ~= cur and vim.fn.buflisted(b) == 1 then
            replacement = b
            break
        end
    end

    if replacement then
        vim.api.nvim_win_set_buf(0, replacement)
        vim.cmd('bd ' .. cur)
    else
        if #wins <= 1 then
            vim.cmd('quit')
        else
            vim.cmd('close')
        end
    end
end

function M.hex_to_rgb(hex)
    hex = tostring(hex or ''):gsub('^#', '')
    if #hex == 3 then
        hex = hex:sub(1, 1):rep(2) .. hex:sub(2, 2):rep(2) .. hex:sub(3, 3):rep(2)
    elseif #hex == 8 then
        hex = hex:sub(1, 6)
    end
    assert(#hex == 6, 'hex_to_rgb: expected #rgb, #rrggbb or #rrggbbaa')
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    return { r = r, g = g, b = b }
end

local rgb_to_hex = function(rgb) return string.format('#%02x%02x%02x', rgb.r, rgb.g, rgb.b) end

local clamp = function(val) return math.max(0, math.min(255, math.floor(val + 0.5))) end

local function norm_percent(p)
    p = tonumber(p) or 0
    if p < 0 then p = 0 end
    if p > 100 then p = 100 end
    return p
end

function M.lighten(color, percent)
    percent = norm_percent(percent)
    local rgb = M.hex_to_rgb(color)
    local factor = percent / 100
    return rgb_to_hex({
        r = clamp(rgb.r + (255 - rgb.r) * factor),
        g = clamp(rgb.g + (255 - rgb.g) * factor),
        b = clamp(rgb.b + (255 - rgb.b) * factor),
    })
end

function M.darken(color, percent)
    percent = norm_percent(percent)
    local rgb = M.hex_to_rgb(color)
    local factor = 1 - (percent / 100)
    return rgb_to_hex({
        r = clamp(rgb.r * factor),
        g = clamp(rgb.g * factor),
        b = clamp(rgb.b * factor),
    })
end

return M
