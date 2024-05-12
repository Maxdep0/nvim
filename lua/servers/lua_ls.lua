-- https://luals.github.io/wiki/
return {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
                checkThirdPart = false,
                library = {
                    -- '${3rd}/luv/library',
                    -- unpack(vim.api.nvim_get_runtime_file('', true)),
                    vim.api.nvim_get_runtime_file('', true),
                },
                maxPreload = 2000,
                preloadFileSize = 500,
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
            semantic = {
                enable = true,
                keyword = false,
            },
            hint = { enable = true },
            hover = { enable = true },
            signatureHelp = { enable = true },

            diagnostics = { enable = true },
            format = { enable = false },
            telemetry = { enable = false },
        },
    },
}
