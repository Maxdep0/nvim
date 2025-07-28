return {
    on_attach = function(client, bufnr) client.server_capabilities.documentFormattingProvider = false end,
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },

    handlers = {},
    commands = {},

    init_options = {
        hostInfo = 'neovim',
        maxTsServerMemory = 4096,
        disableAutomaticTypingAcquisition = true,
        preferences = {
            quotePreference = 'single',
            importModuleSpecifierPreference = 'relative',
            organizeImportsIgnoreCase = false,
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
        },
        tsserver = {
            logVerbosity = 'off',
            useSyntaxServer = 'auto',
        },
    },
}
