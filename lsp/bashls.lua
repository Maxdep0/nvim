-- https://github.com/bash-lsp/bash-language-server
return {
    -- on_attach = function(client, bufnr) client.server_capabilities.documentFormattingProvider = false end,
    cmd = { 'bash-language-server', 'start' },
    settings = {
        bashIde = {
            globPattern = '*@(.sh|.inc|.bash|.command)',
        },
    },
    filetypes = { 'sh', 'bash' },
}
