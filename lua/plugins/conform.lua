return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },

    config = function()
        local conform = require('conform')

        conform.setup({
            formatters_by_ft = {
                lua = { 'stylua' },

                javascript = { 'prettierd' },
                typescript = { 'prettierd' },
                javascriptreact = { 'prettierd' },
                typescriptreact = { 'prettierd' },
                json = { 'prettierd' },
                markdown = { 'prettierd' },
                html = { 'prettierd' },
                css = { 'prettierd' },
                scss = { 'prettierd' },

                python = { 'black' },

                bash = { 'shfmt' },
                mksh = { 'shfmt' },
                shell = { 'shfmt' },
            },

            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            },

            notify_on_error = true,
        })

        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            group = vim.api.nvim_create_augroup('RestartPrettierd', { clear = true }),
            pattern = '*prettier*',
            callback = function()
                vim.fn.system('prettierd restart')
                notify('Prettierd restarted due to config change')
            end,
        })
    end,
}
