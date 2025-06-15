-- Toggle wezterm tab bar to get full transparent mode. Works only on specific linux_env_user name.
local function toggle_wezterm_tab_bar(value)
    if os.getenv('USER') == 'maxdep' then
        local cmd = string.format(
            "sed -i 's/^[[:space:]]*use_fancy_tab_bar[[:space:]]*=.*/use_fancy_tab_bar = %s,/' ~/dotfiles/wezterm/.config/wezterm/wezterm.lua",
            value
        )
        os.execute(cmd)
    end
end

function toggle_transparency()
    local ok, transparent = pcall(vim.api.nvim_get_var, 'isTransparent')

    if not ok or not transparent then
        notify('Enabled Transparent Background', 'UI')

        toggle_wezterm_tab_bar('false')

        for _, hl in ipairs({ 'Normal', 'NormalNC', 'NormalFloat', 'CursorLine', 'StatusLine' }) do
            vim.api.nvim_set_hl(0, hl, { bg = 'none' })
        end

        vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#000000', bg = 'none' })
        vim.api.nvim_set_var('isTransparent', true)
    elseif transparent then
        notify('Disabled Transparent Background', 'UI')

        toggle_wezterm_tab_bar('true')

        vim.cmd('colorscheme nightfox')
        vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#000000', bg = 'none' })
        vim.api.nvim_set_var('isTransparent', false)
    end
end

function toggle_document_highlight()
    if vim.g.document_highlight_active then
        notify('Disabled Document Highlight', 'LSP')

        vim.api.nvim_clear_autocmds({ group = 'lsp_document_highlight' })
        vim.lsp.buf.clear_references()
        vim.g.document_highlight_active = false
    else
        notify('Enabled Document Highlight', 'LSP')

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

function toggle_float_hover()
    local ok, active = pcall(vim.api.nvim_get_var, 'isFloatHoverActive')

    if not ok or not active then
        notify('Enabled Diagnostics Float on Hover', 'LSP')

        local id = vim.api.nvim_create_autocmd('CursorHold', {
            desc = 'Enable float on hover',
            callback = function() vim.diagnostic.open_float(nil, { focus = false }) end,
        })

        vim.api.nvim_set_var('floatHoverAutoCmdId', id)
        vim.api.nvim_set_var('isFloatHoverActive', true)
    elseif active then
        notify('Disabled Diagnostics Float on Hover', 'LSP')

        vim.api.nvim_del_autocmd(vim.api.nvim_get_var('floatHoverAutoCmdId'))
        vim.api.nvim_set_var('isFloatHoverActive', false)
    end
end

function notify(msg, hl)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { msg })

    local width = #msg + 4
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
