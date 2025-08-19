vim.lsp.enable({
    'bashls',
    'cssls',
    'emmet_language_server',
    'html',
    'jsonls',
    -- 'pylsp',
    'pyright',
    'lua_ls',
    'ts_ls',
    'rust-analyzer',
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

vim.api.nvim_create_user_command('Lsp', function() vim.cmd('checkhealth vim.lsp') end, {})
vim.api.nvim_create_user_command('LspBlink', function() vim.cmd('=require("blink.cmp").get_lsp_capabilities()') end, {})

local toggles = require('core.toggles')

local map = function(mode, lhs, rhs, desc, opts)
    opts = vim.tbl_extend('force', { noremap = true, silent = true, desc = desc }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        function check(method, keymap)
            if client:supports_method(method) then map(unpack(keymap)) end
        end

        check('inlayHintProvider', { 'n', '<F3>', toggles.toggle_inlay_hint, 'Toggle inlay hints' })
    end,
})

vim.diagnostic.config({
    update_in_insert = false,
    severity_sort = true,
    virtual_text = {
        prefix = '',
    },
    float = {
        -- focusable = false,
        focusable = true,
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
