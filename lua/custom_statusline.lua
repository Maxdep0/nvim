local M = {}
local api, fn = vim.api, vim.fn

local PAD = { char = ' ', max = 16 }

local colors = {
    bg = '#1e1e2e',
    fg = '#cdd6f4',
    yellow = '#f9e2af',
    cyan = '#89dceb',
    darkblue = '#89b4fa',
    green = '#a6e3a1',
    orange = '#fab387',
    violet = '#f5c2e7',
    magenta = '#cba6f7',
    blue = '#74c7ec',
    red = '#f38ba8',
    gray = '#ababab',
}

local mode_map = {
    n = { color = colors.red, name = 'NORMAL', hl = 'Normal' },
    i = { color = colors.green, name = 'INSERT', hl = 'Insert' },
    v = { color = colors.blue, name = 'VISUAL', hl = 'Visual' },
    ['\022'] = { color = colors.blue, name = 'V-BLOCK', hl = 'VBlock' }, -- <C-V>
    V = { color = colors.blue, name = 'V-LINE', hl = 'VLine' },
    c = { color = colors.magenta, name = 'COMMAND', hl = 'Command' },
    no = { color = colors.red, name = 'PENDING', hl = 'Pending' },
    s = { color = colors.orange, name = 'SELECT', hl = 'Select' },
    S = { color = colors.orange, name = 'S-LINE', hl = 'SLine' },
    ['\019'] = { color = colors.orange, name = 'S-BLOCK', hl = 'SBlock' }, -- <C-S>
    ic = { color = colors.yellow, name = 'INSERT', hl = 'ICompletion' },
    R = { color = colors.violet, name = 'REPLACE', hl = 'Replace' },
    Rv = { color = colors.violet, name = 'VIRTUAL', hl = 'VReplace' },
    cv = { color = colors.red, name = 'EX', hl = 'CvEx' },
    ce = { color = colors.red, name = 'EX', hl = 'CeEx' },
    r = { color = colors.cyan, name = 'REPLACE', hl = 'Replace2' },
    rm = { color = colors.cyan, name = 'MORE', hl = 'More' },
    ['r?'] = { color = colors.cyan, name = 'CONFIRM', hl = 'Confirm' },
    ['!'] = { color = colors.red, name = 'SHELL', hl = 'Shell' },
    t = { color = colors.red, name = 'TERMINAL', hl = 'Terminal' },
}

local function setup_highlights()
    for _, cfg in pairs(mode_map) do
        local group = 'StatuslineMode' .. cfg.hl
        vim.cmd(string.format('hi %s guifg=%s guibg=%s gui=bold', group, colors.bg, cfg.color))
        vim.cmd(string.format('hi %sSep guifg=%s guibg=NONE', group, cfg.color))
    end
    -- vim.cmd('hi StatuslineGit guifg=' .. colors.violet .. ' guibg=NONE gui=bold')
    -- vim.cmd('hi StatuslineLSP guifg=#c4c4c4 guibg=NONE gui=bold')
    -- vim.cmd('hi StatuslineNormal guifg=' .. colors.fg .. ' guibg=NONE')
    -- vim.cmd('hi StatuslineInactive guifg=' .. colors.gray .. ' guibg=NONE')
    -- vim.cmd('hi StatuslineDiffAdd guifg=' .. colors.green .. ' guibg=NONE')
    -- vim.cmd('hi StatuslineDiffMod guifg=' .. colors.orange .. ' guibg=NONE')
    -- vim.cmd('hi StatuslineDiffDel guifg=' .. colors.red .. ' guibg=NONE')
    -- vim.cmd('hi StatuslineDiagError guifg=' .. colors.red .. ' guibg=NONE gui=bold')
    -- vim.cmd('hi StatuslineDiagWarn guifg=' .. colors.yellow .. ' guibg=NONE gui=bold')
    -- vim.cmd('hi StatuslineDiagInfo guifg=' .. colors.cyan .. ' guibg=NONE gui=bold')
    -- vim.cmd('hi StatuslineDiagHint guifg=' .. colors.cyan .. ' guibg=NONE gui=bold')
end

local function get_mode()
    local mode = api.nvim_get_mode().mode
    local info = mode_map[mode] or mode_map.n
    local g = 'StatuslineMode' .. info.hl
    return string.format('%%#%s#  %s %%#%sSep#', g, info.name, g)
end

local function get_git_info()
    local branch = vim.b.gitsigns_head or ''
    if branch == '' then return '' end
    local s = '%#StatuslineGit# ' .. branch
    local gs = vim.b.gitsigns_status_dict
    if gs then
        if (gs.added or 0) > 0 then s = s .. ' %#StatuslineDiffAdd# ' .. gs.added end
        if (gs.changed or 0) > 0 then s = s .. ' %#StatuslineDiffMod# ' .. gs.changed end
        if (gs.removed or 0) > 0 then s = s .. ' %#StatuslineDiffDel# ' .. gs.removed end
    end
    return s .. ' '
end

local function get_lsp_clients()
    local bufnr = api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if next(clients) == nil then return '' end
    local ft = api.nvim_get_option_value('filetype', { buf = bufnr })
    for _, c in pairs(clients) do
        local fts = c.config.filetypes or {}
        if vim.tbl_contains(fts, ft) then return '%#StatuslineLSP#⚙️ ' .. c.name .. ' ' end
    end
    return ''
end

local function get_diagnostics()
    local out, levels =
        {}, {
            { name = 'Error', icon = ' ', hl = 'StatuslineDiagError' },
            { name = 'Warn', icon = ' ', hl = 'StatuslineDiagWarn' },
            { name = 'Info', icon = ' ', hl = 'StatuslineDiagInfo' },
            { name = 'Hint', icon = ' ', hl = 'StatuslineDiagHint' },
        }
    for _, L in ipairs(levels) do
        local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[L.name:upper()] })
        if n > 0 then table.insert(out, string.format('%%#%s#%s%d', L.hl, L.icon, n)) end
    end
    return (#out > 0) and (table.concat(out, ' ') .. ' ') or ''
end

local function sl_width(s)
    if not s or s == '' then return 0 end
    local w, i = 0, 1
    while i <= #s do
        local hs, he = s:find('%%#.-#', i)
        if hs == i then
            i = he + 1
        else
            local b = s:byte(i)
            local step = (b >= 0xF0) and 4 or (b >= 0xE0) and 3 or (b >= 0xC0) and 2 or 1
            local ch = s:sub(i, i + step - 1)
            w = w + fn.strdisplaywidth(ch)
            i = i + step
        end
    end
    return w
end

local function get_buffers(maxw)
    local items, current = {}, api.nvim_get_current_buf()
    local current_idx = 0

    for _, buf in ipairs(api.nvim_list_bufs()) do
        local listed = api.nvim_get_option_value('buflisted', { buf = buf })
        if api.nvim_buf_is_loaded(buf) and listed then
            local name = api.nvim_buf_get_name(buf)
            if name ~= '' then
                name = fn.fnamemodify(name, ':t')
                local mod = api.nvim_get_option_value('modified', { buf = buf }) and '● ' or ''
                if buf == current then
                    current_idx = #items + 1
                    table.insert(items, '%#StatuslineNormal# ' .. mod .. name)
                else
                    table.insert(items, '%#StatuslineInactive#' .. mod .. name)
                end
            end
        end
    end

    if #items == 0 then return '' end
    if current_idx == 0 then current_idx = 1 end

    local SEP = '  '
    local sepw = fn.strdisplaywidth(SEP)
    local ell = '…'
    local ellw = fn.strdisplaywidth(ell)

    local widths = {}
    for i, it in ipairs(items) do
        widths[i] = sl_width(it)
    end

    local l, r = current_idx, current_idx
    local lw, rw = 0, 0
    local used = widths[current_idx]

    local function fits(w) return used + sepw + w <= maxw end

    while true do
        local wl = (l > 1) and widths[l - 1] or nil
        local wr = (r < #items) and widths[r + 1] or nil
        local canL, canR = wl and fits(wl), wr and fits(wr)
        if not canL and not canR then break end

        if canL and not canR then
            used = used + sepw + wl
            l = l - 1
            lw = lw + sepw + wl
        elseif canR and not canL then
            used = used + sepw + wr
            r = r + 1
            rw = rw + sepw + wr
        else
            local dl = math.abs((lw + sepw + wl) - rw)
            local dr = math.abs(lw - (rw + sepw + wr))
            if dl <= dr then
                used = used + sepw + wl
                l = l - 1
                lw = lw + sepw + wl
            else
                used = used + sepw + wr
                r = r + 1
                rw = rw + sepw + wr
            end
        end
    end

    local out = {}
    if l > 1 then table.insert(out, '%#StatuslineInactive#' .. ell) end
    for i = l, r do
        if #out > 0 then table.insert(out, SEP) end
        table.insert(out, items[i])
    end
    if r < #items then
        table.insert(out, SEP)
        table.insert(out, '%#StatuslineInactive#' .. ell)
    end

    local content = table.concat(out)

    local left_total = lw + (l > 1 and (ellw + sepw) or 0)
    local right_total = rw + (r < #items and (sepw + ellw) or 0)

    local diff = left_total - right_total -- +ve => left heavier
    local slack = math.max(0, maxw - sl_width(content)) -- cells before/after
    local need = math.min(math.abs(diff), slack, PAD.max)
    if need > 0 then
        local pad = string.rep(PAD.char, need)
        if diff > 0 then
            content = content .. pad -- add to right
        else
            content = pad .. content -- add to left
        end
    end

    return content
end

local function get_location()
    local mode = api.nvim_get_mode().mode
    local info = mode_map[mode] or mode_map.n
    local g = 'StatuslineMode' .. info.hl
    local line, col = fn.line('.'), fn.col('.')
    return string.format('%%#%sSep#%%#%s#  %d:%d  ', g, g, line, col)
end

function M.active()
    local left = get_mode() .. get_git_info()
    local right = get_lsp_clients() .. get_diagnostics() .. get_location()

    local win_w = api.nvim_win_get_width(0) -- current window width
    local max_buf = math.max(8, win_w - sl_width(left) - sl_width(right))

    return table.concat({
        left,
        '%=',
        get_buffers(max_buf),
        '%=',
        right,
    }, '')
end

function M.inactive() return '%#StatuslineInactive# %f %=' end

function M.setup()
    setup_highlights()
    vim.opt.laststatus = 3
    vim.opt.statusline = "%!v:lua.require('custom_statusline').active()"
    api.nvim_create_autocmd(
        { 'ModeChanged', 'BufEnter', 'BufWritePost', 'DiagnosticChanged', 'LspAttach', 'LspDetach', 'WinResized' },
        { callback = function() vim.cmd('redrawstatus') end }
    )
end

return M
