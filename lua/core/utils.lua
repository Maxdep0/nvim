local M = {}

function toggleWeztermTabBar(value)
    local linux_env_user = os.getenv('USER')
    if linux_env_user == 'maxdep' then
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
        vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })

        vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'CursorLine', { bg = 'none' })
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none' })
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

function toggleSignatureHelp()
    local ok, signatureHelpActive = pcall(vim.api.nvim_get_var, 'isSignatureHelp')

    if not ok or not signatureHelpActive then
        M.notify('Enabled Signature Help', 'LSP')

        local autocmd_id = vim.api.nvim_create_autocmd('CursorHoldI', {
            desc = 'Enable Signature Help in Insert Mode',
            callback = function()
                vim.lsp.buf.signature_help()
            end,
        })

        vim.api.nvim_set_var('signatureHelpAutoCmdId', autocmd_id)
        vim.api.nvim_set_var('isSignatureHelp', true)
    else
        M.notify('Disabled Signature Help', 'LSP')
        local autocmd_id = vim.api.nvim_get_var('signatureHelpAutoCmdId')

        vim.api.nvim_del_autocmd(autocmd_id)
        vim.api.nvim_set_var('isSignatureHelp', false)
    end
end

function toggleFloatHover()
    local ok, floatHover = pcall(vim.api.nvim_get_var, 'isFloatHover')

    if not ok or not floatHover then
        M.notify('Enabled Diagnostics Float on Hover', 'LSP')

        local autocmd_id = vim.api.nvim_create_autocmd('CursorHold', {
            desc = 'Enable float on hover',
            callback = function()
                vim.diagnostic.open_float(nil, { focus = false })
            end,
        })

        vim.api.nvim_set_var('floatHoverAutoCmdId', autocmd_id)
        vim.api.nvim_set_var('isFloatHover', true)
    elseif floatHover then
        M.notify('Disabled Diagnostics Float on Hover', 'LSP')

        local autocmd_id = vim.api.nvim_get_var('floatHoverAutoCmdId')

        vim.api.nvim_del_autocmd(autocmd_id)
        vim.api.nvim_set_var('isFloatHover', false)
    end
end

function M.notify(msg, ann)
    local _, fidget = pcall(require, 'fidget')
    fidget.notify(msg, vim.log.levels.INFO, { annote = ann })
end

return M
