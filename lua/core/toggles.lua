local M = {}

-- Toggle wezterm tab bar to get full transparent mode. Works only on specific linux_env_user name.
function toggleWeztermTabBar(value)
    if os.getenv('USER') == 'maxdep' then
        local cmd = string.format(
            "sed -i 's/^[[:space:]]*use_fancy_tab_bar[[:space:]]*=.*/use_fancy_tab_bar = %s,/' ~/dotfiles/wezterm/.config/wezterm/wezterm.lua",
            value
        )
        os.execute(cmd)
    end
end

function saveAndCloseCurrentBuffer()
    vim.cmd('write')
    local current_buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_delete(current_buf, { force = false })
end

function toggleTransparency()
    local ok, transparent = pcall(vim.api.nvim_get_var, 'isTransparent')

    if not ok or not transparent then
        M.notify('Enabled Transparent Background', 'UI')

        toggleWeztermTabBar('false')

        for _, hl in ipairs({ 'Normal', 'NormalNC', 'NormalFloat', 'CursorLine', 'StatusLine' }) do
            vim.api.nvim_set_hl(0, hl, { bg = 'none' })
        end

        vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#000000', bg = 'none' })
        vim.api.nvim_set_var('isTransparent', true)
    elseif transparent then
        M.notify('Disabled Transparent Background', 'UI')

        toggleWeztermTabBar('true')

        vim.cmd('colorscheme nightfox')
        vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#000000', bg = 'none' })
        vim.api.nvim_set_var('isTransparent', false)
    end
end

function toggleDocumentHighlight()
    if vim.g.document_highlight_active then
        M.notify('Disabled Document Highlight', 'LSP')

        vim.api.nvim_clear_autocmds({ group = 'lsp_document_highlight' })
        vim.lsp.buf.clear_references()
        vim.g.document_highlight_active = false
    else
        M.notify('Enabled Document Highlight', 'LSP')

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

function toggleFloatHover()
    local ok, active = pcall(vim.api.nvim_get_var, 'isFloatHoverActive')

    if not ok or not active then
        M.notify('Enabled Diagnostics Float on Hover', 'LSP')

        local id = vim.api.nvim_create_autocmd('CursorHold', {
            desc = 'Enable float on hover',
            callback = function() vim.diagnostic.open_float(nil, { focus = false }) end,
        })

        vim.api.nvim_set_var('floatHoverAutoCmdId', id)
        vim.api.nvim_set_var('isFloatHoverActive', true)
    elseif active then
        M.notify('Disabled Diagnostics Float on Hover', 'LSP')

        vim.api.nvim_del_autocmd(vim.api.nvim_get_var('floatHoverAutoCmdId'))
        vim.api.nvim_set_var('isFloatHoverActive', false)
    end
end

function M.notify(msg, ann)
    local _, fidget = pcall(require, 'fidget')
    fidget.notify(msg, vim.log.levels.INFO, { annote = ann })
end

return M
