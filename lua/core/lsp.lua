vim.lsp.enable({
    'bashls',
    'cssls',
    'emmet_language_server',
    'html',
    'jsonls',
    'pylsp',
    'lua_ls',
    'ts_ls',
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

vim.diagnostic.config({
    update_in_insert = false,
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
    capabilities = capabilities,
})
