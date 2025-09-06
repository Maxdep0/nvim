local M = {}

function M.toggle_windows_layout()
    local total_wins = vim.fn.winnr('$')
    if total_wins == 1 then return end

    local cur_win = vim.fn.winnr()
    local has_vertical_split = vim.fn.winnr('h') ~= cur_win or vim.fn.winnr('l') ~= cur_win

    vim.cmd(has_vertical_split and 'windo wincmd J' or 'windo wincmd H')
end

function M.toggle_transparency()
    local ok, transparent = pcall(vim.api.nvim_get_var, 'isTransparent')

    if not ok or not transparent then
        M.notify('Enabled Transparent Background')

        vim.fn.system({ 'bash', vim.fn.stdpath('config') .. '/scripts/toggle_wezterm_tab.sh', 'false' })

        for _, hl in ipairs({ 'Normal', 'NormalNC', 'NormalFloat', 'CursorLine', 'StatusLine' }) do
            vim.api.nvim_set_hl(0, hl, { bg = 'none' })
        end

        vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#000000', bg = 'none' })
        vim.api.nvim_set_var('isTransparent', true)
    elseif transparent then
        M.notify('Disabled Transparent Background')

        vim.fn.system({ 'bash', vim.fn.stdpath('config') .. '/scripts/toggle_wezterm_tab.sh', 'true' })

        vim.cmd('colorscheme maxo')
        vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#000000', bg = 'none' })
        vim.api.nvim_set_var('isTransparent', false)
    end
end

function M.toggle_document_highlight()
    if vim.g.document_highlight_active then
        M.notify('Disabled Document Highlight')

        vim.api.nvim_clear_autocmds({ group = 'lsp_document_highlight' })
        vim.lsp.buf.clear_references()
        vim.g.document_highlight_active = false
    else
        M.notify('Enabled Document Highlight')

        vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
        vim.api.nvim_create_autocmd('CursorHold', {
            callback = vim.lsp.buf.document_highlight,
            group = 'lsp_document_highlight',
            desc = 'Document Highlight',
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
            callback = vim.lsp.buf.clear_references,
            group = 'lsp_document_highlight',
            desc = 'Clear All the References',
        })
        vim.g.document_highlight_active = true
    end
end

function M.toggle_inlay_hint()
    if vim.lsp.inlay_hint.is_enabled() then
        M.notify('Disabled Inlay Hint')
        vim.lsp.inlay_hint.enable(false)
    else
        M.notify('Enabled Inlay Hint')
        vim.lsp.inlay_hint.enable(true)
    end
end

function M.toggle_float_hover()
    local ok, active = pcall(vim.api.nvim_get_var, 'isFloatHoverActive')

    if not ok or not active then
        M.notify('Enabled Diagnostics Float on Hover')

        local id = vim.api.nvim_create_autocmd('CursorHold', {
            desc = 'Enable float on hover',
            callback = function() vim.diagnostic.open_float(nil, { focus = false }) end,
        })

        vim.api.nvim_set_var('floatHoverAutoCmdId', id)
        vim.api.nvim_set_var('isFloatHoverActive', true)
    elseif active then
        M.notify('Disabled Diagnostics Float on Hover')

        vim.api.nvim_del_autocmd(vim.api.nvim_get_var('floatHoverAutoCmdId'))
        vim.api.nvim_set_var('isFloatHoverActive', false)
    end
end

function M.notify(msg, hl)
    -- local buf = vim.api.nvim_create_buf(false, true)
    -- vim.api.nvim_buf_set_lines(buf, 0, -1, false, { msg })

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { msg })
    vim.api.nvim_set_option_value('modifiable', false, { buf = buf })

    local width = #msg
    local height = 1
    local col = vim.o.columns - width - 2
    local opts = {
        style = 'minimal',
        relative = 'editor',
        row = 1,
        col = col,
        width = width,
        height = height,
        border = 'rounded',
    }
    local win = vim.api.nvim_open_win(buf, false, opts)
    vim.api.nvim_set_option_value('winhl', 'Normal:' .. (hl or 'Normal'), { win = win })

    vim.defer_fn(function() pcall(vim.api.nvim_win_close, win, true) end, 2000)
end

local state = {
    terminal = { buf = -1, win = -1 },
}

function M.toggle_terminal()
    local function create_floating_window()
        local width = math.floor(vim.o.columns * 0.5)
        local height = math.floor(vim.o.lines * 0.5)

        local buf = vim.api.nvim_create_buf(false, true)

        local win_config = {
            relative = 'editor',
            width = width,
            height = height,
            row = math.floor((vim.o.lines - height) / 2),
            col = math.floor((vim.o.columns - width) / 2),
            style = 'minimal',
            border = 'rounded',
        }

        local win = vim.api.nvim_open_win(buf, true, win_config)

        return { buf = buf, win = win }
    end

    if not vim.api.nvim_win_is_valid(state.terminal.win) then
        state.terminal = create_floating_window()
        if vim.bo[state.terminal.buf].buftype ~= 'terminal' then vim.cmd.terminal() end

        vim.cmd('normal i')
    else
        vim.api.nvim_buf_delete(state.terminal.buf, { force = true })
    end
end

return M
