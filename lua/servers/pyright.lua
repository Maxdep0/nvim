return {
    python = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    diagnosticMode = 'workspace',
                    typeCheckingMode = 'basic',
                },
            },
        },
    },
}
