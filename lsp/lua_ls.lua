-- https://luals.github.io/wiki/
return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                checkThirdPart = false,
                library = {
                    '${3rd}/luv/library',
                    unpack(vim.api.nvim_get_runtime_file('', true)),
                    -- vim.api.nvim_get_runtime_file('', true),
                },
                maxPreload = 2000,
                preloadFileSize = 500,
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
                disable = { 'missing-fields' },
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

            format = { enable = false },

            telemetry = { enable = false },
        },
    },
}
