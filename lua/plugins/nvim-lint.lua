return {
    'mfussenegger/nvim-lint',
    event = {
        'BufReadPre',
        'BufNewFile',
    },

    config = function()
        local lint = require('lint')

        lint.linters_by_ft = {
            lua = { 'selene' },
            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            python = { 'flake8' },
            bash = { 'shellcheck' },
            css = { 'stylelint' },
            sass = { 'stylelint' },
            scss = { 'stylelint' },
            less = { 'stylelint' },
            html = { 'htmlhint' },
        }

        local function getSeleneConfig()
            local projectConfig = vim.fn.getcwd() .. '/selene.toml'
            local globalConfig = vim.fn.stdpath('config') .. '/selene.toml'
            if vim.fn.filereadable(projectConfig) == 1 then
                return projectConfig
            else
                return globalConfig
            end
        end

        -- Use 'nvim/selene.toml' config if using '<space>sn' from different directory
        lint.linters.selene.args = { '--display-style', 'json', '-', '--config', getSeleneConfig() }

        lint.linters.eslint_d.args = {
            -- '--no-warn-ignored',
            '--format',
            'json',
            '--stdin',
            '--stdin-filename',
            function()
                return vim.api.nvim_buf_get_name(0)
            end,
        }

        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            group = vim.api.nvim_create_augroup('RestartEslint', { clear = true }),
            pattern = '*eslint*',
            callback = function()
                vim.fn.system('eslint_d restart')
            end,
        })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = vim.api.nvim_create_augroup('StartLinting', { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
