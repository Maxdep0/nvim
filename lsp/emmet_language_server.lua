return {
    cmd = { 'emmet-language-server', '--stdio' },
    filetypes = {
        'css',
        'eruby',
        'html',
        'htmldjango',
        'javascriptreact',
        'less',
        'pug',
        'sass',
        'scss',
        'typescriptreact',
        'ts_ls',
    },
    init_options = { provideFormatter = true },
    settings = {
        css = { validate = true },
        less = { validate = true },
        scss = { validate = true },
    },
}
