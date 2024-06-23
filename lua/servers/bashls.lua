-- https://github.com/bash-lsp/bash-language-server
return {
    cmd = { 'bash-language-server', 'start' },
    setting = {
        bashIde = {
            globPattern = '*@(.sh|.inc|.bash|.command)',
        },
    },
    filetypes = { 'sh' },
}
