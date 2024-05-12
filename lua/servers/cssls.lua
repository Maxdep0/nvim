return {
    cmd = { 'vscode-css-language-server', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
    init_options = { provideFormatter = true },
    settings = {
        css = {
            validate = true,
        },
        less = {
            validate = true,
        },
        scss = {
            validate = true,
        },
    },
}
