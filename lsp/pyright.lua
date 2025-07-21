return {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { '.venv', '.git', 'pyproject.toml' },
    settings = {
        python = {
            analysis = {
                autoImportCompletions = true,
                autoSearchPaths = true,
                stubPath = 'typings',
                -- typeCheckingMode = 'strict',
                useLibraryCodeForTypes = true,
                diagnosticMode = 'openFilesOnly',
                logLevel = 'Error',
            },
        },
    },
}
