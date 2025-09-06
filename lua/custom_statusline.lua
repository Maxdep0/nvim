-- NOTE: Colors used from colorscheme (colors/maxo.lua)
-- TODO: Add default fallback colors if not defined in colorscheme

local api = vim.api

local cache = {
    git = { data = '', time = 0, ttl = 1000 },
    diag = { data = '', time = 0, ttl = 5000 },
    buff = { data = '', time = 0, ttl = 5000 },
}

local debug_mode = false
local call_count = 0
local cache_stats = {
    git = { hits = 0, misses = 0 },
    diag = { hits = 0, misses = 0 },
    buff = { hits = 0, misses = 0 },
}
local now = 0

local mode_map = {
    n = { name = 'NORMAL', hl = 'Normal' },
    i = { name = 'INSERT', hl = 'Insert' },
    v = { name = 'VISUAL', hl = 'Visual' },
    ['\022'] = { name = 'V-BLOCK', hl = 'VBlock' },
    V = { name = 'V-LINE', hl = 'VLine' },
    c = { name = 'COMMAND', hl = 'Command' },
    no = { name = 'PENDING', hl = 'Pending' },
    s = { name = 'SELECT', hl = 'Select' },
    S = { name = 'S-LINE', hl = 'SLine' },
    ['\019'] = { name = 'S-BLOCK', hl = 'SBlock' },
    ic = { name = 'INSERT', hl = 'ICompletion' },
    R = { name = 'REPLACE', hl = 'Replace' },
    Rv = { name = 'VIRTUAL', hl = 'VReplace' },
    cv = { name = 'EX', hl = 'CvEx' },
    ce = { name = 'EX', hl = 'CeEx' },
    r = { name = 'REPLACE', hl = 'Replace2' },
    rm = { name = 'MORE', hl = 'More' },
    ['r?'] = { name = 'CONFIRM', hl = 'Confirm' },
    ['!'] = { name = 'SHELL', hl = 'Shell' },
    t = { name = 'TERMINAL', hl = 'Terminal' },
}

local M = {}

local function get_debug_info()
    local total_hits, total_misses = 0, 0
    for _, stats in pairs(cache_stats) do
        total_hits = total_hits + stats.hits
        total_misses = total_misses + stats.misses
    end

    local hit_rate = 0
    if total_hits + total_misses > 0 then hit_rate = math.floor(total_hits / (total_hits + total_misses) * 100) end
    local details = string.format(
        'Git:%d/%d Diag:%d/%d Buff:%d/%d',
        cache_stats.git.hits,
        cache_stats.git.misses,
        cache_stats.diag.hits,
        cache_stats.diag.misses,
        cache_stats.buff.hits,
        cache_stats.buff.misses
    )
    return string.format('%%#Comment# [#%d %s (%d%%)] ', call_count, details, hit_rate)
end

local function is_cache_valid(cache_entry) return (now - cache_entry.time) < cache_entry.ttl end

local function get_mode(mode)
    local info = mode_map[mode] or mode_map.n
    local g = 'StatuslineMode' .. info.hl
    return string.format('%%#%s# %s %%#%sSep#', g, info.name, g)
end

local function get_git_info()
    if is_cache_valid(cache.git) then
        if debug_mode then cache_stats.git.hits = cache_stats.git.hits + 1 end
        return cache.git.data
    end
    if debug_mode then cache_stats.git.misses = cache_stats.git.misses + 1 end

    local branch = vim.b.gitsigns_head or ''
    if branch == '' then
        cache.git.data = ''
        cache.git.time = now
        return ''
    end

    local s = '%#StatuslineGit# ' .. branch
    local gs = vim.b.gitsigns_status_dict
    if gs then
        if (gs.added or 0) > 0 then s = s .. ' %#GitSignsAdd#' .. gs.added end
        if (gs.changed or 0) > 0 then s = s .. ' %#GitSignsChange#' .. gs.changed end
        if (gs.removed or 0) > 0 then s = s .. ' %#GitSignsDelete#' .. gs.removed end
    end

    cache.git.data = s .. ' '
    cache.git.time = now
    return cache.git.data
end

local function get_buffers(max_items)
    if is_cache_valid(cache.buff) then
        if debug_mode then cache_stats.buff.hits = cache_stats.buff.hits + 1 end
        return cache.buff.data
    end
    if debug_mode then cache_stats.buff.misses = cache_stats.buff.misses + 1 end

    max_items = max_items or 5
    local bufs, cur = {}, api.nvim_get_current_buf()

    for _, b in ipairs(api.nvim_list_bufs()) do
        if api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted then bufs[#bufs + 1] = b end
    end
    if #bufs == 0 then
        cache.buff.data = ''
        cache.buff.time = now
        return ''
    end

    local cur_i = 1
    for i, b in ipairs(bufs) do
        if b == cur then
            cur_i = i
            break
        end
    end

    local half = math.floor((max_items - 1) / 2)
    local s = math.max(cur_i - half, 1)
    local e = math.min(s + max_items - 1, #bufs)
    s = math.max(e - max_items + 1, 1)

    local items = {}
    if s > 1 then items[#items + 1] = '…' end
    for i = s, e do
        local b = bufs[i]
        local name = vim.fs.basename(api.nvim_buf_get_name(b))
        if name ~= '' then
            local mod = vim.bo[b].modified and '● ' or ''
            if b == cur then
                items[#items + 1] = '%#StatuslineNormal#' .. mod .. name
            else
                items[#items + 1] = '%#StatuslineInactive#' .. mod .. name
            end
        end
    end
    if e < #bufs then items[#items + 1] = '…' end

    cache.buff.data = table.concat(items, ' ')
    cache.buff.time = now
    return cache.buff.data
end

local function get_diagnostics()
    if is_cache_valid(cache.diag) then
        if debug_mode then cache_stats.diag.hits = cache_stats.diag.hits + 1 end
        return cache.diag.data
    end
    if debug_mode then cache_stats.diag.misses = cache_stats.diag.misses + 1 end

    local counts = vim.diagnostic.count(0)
    local out, levels =
        {}, {
            { vim.diagnostic.severity.ERROR, 'StatuslineDiagError' },
            { vim.diagnostic.severity.WARN, 'StatuslineDiagWarn' },
            { vim.diagnostic.severity.INFO, 'StatuslineDiagInfo' },
            { vim.diagnostic.severity.HINT, 'StatuslineDiagHint' },
        }

    for _, L in ipairs(levels) do
        local n = counts[L[1]]
        if n and n > 0 then table.insert(out, string.format('%%#%s#%d', L[2], n)) end
    end

    cache.diag.data = (#out > 0) and (table.concat(out, ' ') .. ' ') or ''
    cache.diag.time = now
    return cache.diag.data
end

local function get_location(mode)
    local info = mode_map[mode] or mode_map.n
    local g = 'StatuslineMode' .. info.hl
    return '%#' .. g .. 'Sep#%#' .. g .. '# %l:%c '
end

function M.toggle_debug()
    debug_mode = not debug_mode
    vim.cmd('redrawstatus')
    print('Statusline debug:', debug_mode and 'ON' or 'OFF')
end

function M.active()
    now = vim.loop.now()
    local mode = api.nvim_get_mode().mode

    local left = get_mode(mode) .. get_git_info()
    local middle = '%<%* ' .. get_buffers() .. ' %*'
    local right = get_diagnostics() .. get_location(mode)

    local out = left .. '   ' .. '%=' .. middle .. '%=' .. '   ' .. right

    if debug_mode then
        call_count = call_count + 1
        return out .. get_debug_info()
    end

    return out
end

function M.inactive() return '%#StatuslineInactive# %f %=' end

function M.setup()
    vim.opt.laststatus = 3
    vim.opt.statusline = "%!v:lua.require('custom_statusline').active()"

    local aug = api.nvim_create_augroup('StatuslineCache', { clear = true })

    api.nvim_create_autocmd({ 'BufAdd', 'BufDelete', 'BufModifiedSet', 'BufEnter' }, {
        group = aug,
        callback = function() cache.buff.time = 0 end,
    })

    api.nvim_create_autocmd('DiagnosticChanged', {
        group = aug,
        callback = function() cache.diag.time = 0 end,
    })

    vim.api.nvim_create_user_command('Statusline', function(opts)
        if opts.args == 'debug' then M.toggle_debug() end
    end, { nargs = 1 })
end

return M
