local utils = require('core.utils')

local on_attach = function(client, bufnr)
    local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    if client.server_capabilities.signatureHelpProvider then
        map('<F3>', function()
            utils.toggleSignatureHelp(bufnr)
        end, 'SPECIAL: Toggle Signature Help')
        utils.toggleSignatureHelp(bufnr)
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

vim.diagnostic.config({
    update_in_intesrt = false,
    severity_sort = true,
    virtual_text = {
        prefix = '',
    },
    float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = true,
        header = '',
        prefix = '',
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '● ',
            [vim.diagnostic.severity.WARN] = '● ',
            [vim.diagnostic.severity.INFO] = '● ',
            [vim.diagnostic.severity.HINT] = '● ',
        },
    },
})

vim.lsp.config('*', {
    on_attach = on_attach,
    capabilities = capabilities,
})
