return {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { '.venv', '.git', 'pyproject.toml' },
    settings = {
        python = {
            analysis = {
                -- diagnosticMode = 'openFilesOnly',
                typeCheckingMode = 'basic',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
}
