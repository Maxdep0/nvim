-- https://luals.github.io/wiki/
return {
    on_attach = function(client, bufnr) client.server_capabilities.documentFormattingProvider = false end,

    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    '${3rd}/luv/library',
                    unpack(vim.api.nvim_get_runtime_file('', true)),
                    -- vim.api.nvim_get_runtime_file('', true),
                },
                maxPreload = 1000,
                preloadFileSize = 200,
            },

            hint = { enable = true },
            hover = { enable = true },
            signatureHelp = { enable = true },

            semantic = {
                enable = true,
                keyword = false,
            },

            diagnostics = {
                enable = true,
                disable = { 'missing-fields', 'lowercase-global' },
                globals = { 'vim' },
                deprecated = true,
            },

            completion = {
                enable = true,
                callSnippet = 'Replace',
                displayContext = 5,
                keywordSnippet = 'Replace',
                postfix = '@',
                requireSeparator = '.',
                showParams = true,
                showWord = 'Fallback',
                workspaceWord = true,
            },

            telemetry = { enable = false },
        },
    },
}
