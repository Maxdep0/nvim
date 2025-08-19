local M = {}
local api, fn, o = vim.api, vim.fn, vim.o

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
    ['\022'] = { color = colors.blue, name = 'V-BLOCK', hl = 'VBlock' }, -- <C-V> char
    V = { color = colors.blue, name = 'V-LINE', hl = 'VLine' },
    c = { color = colors.magenta, name = 'COMMAND', hl = 'Command' },
    no = { color = colors.red, name = 'PENDING', hl = 'Pending' },
    s = { color = colors.orange, name = 'SELECT', hl = 'Select' },
    S = { color = colors.orange, name = 'S-LINE', hl = 'SLine' },
    ['\019'] = { color = colors.orange, name = 'S-BLOCK', hl = 'SBlock' }, -- <C-S> char
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
    for _, config in pairs(mode_map) do
        local group_name = 'StatuslineMode' .. config.hl
        vim.cmd(string.format('hi %s guifg=%s guibg=%s gui=bold', group_name, colors.bg, config.color))
        vim.cmd(string.format('hi %sSep guifg=%s guibg=NONE', group_name, config.color))
    end

    -- Optional extra groups you referenced elsewhere:
    -- vim.cmd('hi StatuslineGit guifg=' .. colors.violet .. ' guibg=NONE gui=bold')
    -- vim.cmd('hi StatuslineLSP guifg=#c4c4c4 guibg=NONE gui=bold')
    -- vim.cmd('hi StatuslineNormal guifg=' .. colors.fg .. ' guibg=NONE')
    -- vim.cmd('hi StatuslineDiffAdd guifg=' .. colors.green .. ' guibg=NONE')
    -- vim.cmd('hi StatuslineDiffMod guifg=' .. colors.orange .. ' guibg=NONE')
    -- vim.cmd('hi StatuslineDiffDel guifg=' .. colors.red .. ' guibg=NONE')
    -- vim.cmd('hi StatuslineDiagError guifg=' .. colors.red .. ' guibg=NONE gui=bold')
    -- vim.cmd('hi StatuslineDiagWarn guifg=' .. colors.yellow .. ' guibg=NONE gui=bold')
    -- vim.cmd('hi StatuslineDiagInfo guifg=' .. colors.cyan .. ' guibg=NONE gui=bold')
    -- vim.cmd('hi StatuslineDiagHint guifg=' .. colors.cyan .. ' guibg=NONE gui=bold')
    -- vim.cmd('hi StatuslineInactive guifg=' .. colors.gray .. ' guibg=NONE')
end

local function get_mode()
    local mode = api.nvim_get_mode().mode
    local mode_info = mode_map[mode] or mode_map.n
    local mode_group = 'StatuslineMode' .. mode_info.hl
    local sep_group = mode_group .. 'Sep'
    return string.format('%%#%s#  %s %%#%s#', mode_group, mode_info.name, sep_group)
end

local function get_git_info()
    local branch = vim.b.gitsigns_head or ''
    if branch == '' then return '' end
    local result = '%#StatuslineGit# ' .. branch
    local gs = vim.b.gitsigns_status_dict
    if gs then
        if (gs.added or 0) > 0 then result = result .. ' %#StatuslineDiffAdd# ' .. gs.added end
        if (gs.changed or 0) > 0 then result = result .. ' %#StatuslineDiffMod# ' .. gs.changed end
        if (gs.removed or 0) > 0 then result = result .. ' %#StatuslineDiffDel# ' .. gs.removed end
    end
    return result .. ' '
end

local function get_lsp_clients()
    local bufnr = api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if next(clients) == nil then return '' end
    local ft = api.nvim_get_option_value('filetype', { buf = bufnr })
    for _, client in pairs(clients) do
        local fts = client.config.filetypes or {}
        if vim.tbl_contains(fts, ft) then return '%#StatuslineLSP#⚙️ ' .. client.name .. ' ' end
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

local function sl_truncate(s, maxw)
    if maxw <= 0 then return '' end
    local out, used, i = {}, 0, 1
    while i <= #s do
        local hs, he = s:find('%%#.-#', i)
        if hs == i then
            table.insert(out, s:sub(hs, he))
            i = he + 1
        else
            local b = s:byte(i)
            local step = (b >= 0xF0) and 4 or (b >= 0xE0) and 3 or (b >= 0xC0) and 2 or 1
            local ch = s:sub(i, i + step - 1)
            local w = fn.strdisplaywidth(ch)
            if used + w > maxw then
                table.insert(out, '…')
                break
            end
            table.insert(out, ch)
            used = used + w
            i = i + step
        end
    end
    return table.concat(out)
end

local function get_buffers()
    local items, current = {}, api.nvim_get_current_buf()
    for _, buf in ipairs(api.nvim_list_bufs()) do
        local is_listed = api.nvim_get_option_value('buflisted', { buf = buf })
        if api.nvim_buf_is_loaded(buf) and is_listed then
            local name = api.nvim_buf_get_name(buf)
            if name ~= '' then
                name = fn.fnamemodify(name, ':t')
                local modified = api.nvim_get_option_value('modified', { buf = buf }) and '● ' or ''
                if buf == current then
                    table.insert(items, '%#StatuslineNormal# ' .. modified .. name)
                else
                    table.insert(items, '%#StatuslineInactive#' .. modified .. name)
                end
            end
        end
    end
    local joined = table.concat(items, '  ')
    local maxw = math.floor(o.columns * 0.5) ------ <<<<<<<<<<<
    return sl_truncate(joined, maxw)
end

local function get_location()
    local mode = api.nvim_get_mode().mode
    local mode_info = mode_map[mode] or mode_map.n
    local mode_group = 'StatuslineMode' .. mode_info.hl
    local sep_group = mode_group .. 'Sep'
    local line, col = fn.line('.'), fn.col('.')
    return string.format('%%#%s#%%#%s#  %d:%d  ', sep_group, mode_group, line, col)
end

function M.active()
    return table.concat({
        get_mode(),
        get_git_info(),
        '%=', -- left>>> center split
        get_buffers(),
        '%=', -- center >>> right split
        get_lsp_clients(),
        get_diagnostics(),
        get_location(),
    }, '')
end

function M.inactive() return '%#StatuslineInactive# %f %=' end

function M.setup()
    setup_highlights()
    vim.opt.laststatus = 3
    vim.opt.statusline = "%!v:lua.require('custom_statusline').active()"
    api.nvim_create_autocmd(
        { 'ModeChanged', 'BufEnter', 'BufWritePost', 'DiagnosticChanged', 'LspAttach', 'LspDetach' },
        { callback = function() vim.cmd('redrawstatus') end }
    )
end

return M
