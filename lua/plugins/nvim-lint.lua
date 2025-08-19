return {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },

    config = function()
        local lint = require('lint')

        lint.linters.zsh_parse = {
            cmd = 'zsh',
            stdin = false,
            append_fname = true,
            args = { '--no-exec', '--no-rcs', '--no-globalrcs' },
            stream = 'stderr',
            ignore_exitcode = true,
            -- parser = require('lint.parser').from_errorformat('%s:%l:%m', {
            parser = require('lint.parser').from_errorformat('%f:%l:%m', {
                source = 'zsh',
                severity = vim.diagnostic.severity.ERROR,
            }),
        }

        lint.linters_by_ft = {
            lua = { 'selene' },
            javascript = { 'eslint_d' },
            typescript = { 'eslint_d' },
            javascriptreact = { 'eslint_d' },
            typescriptreact = { 'eslint_d' },
            python = { 'flake8' },
            bash = { 'shellcheck' },
            sh = { 'shellcheck' },

            zsh = { 'zsh_parse' },
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
            '--format',
            'json',
            '--stdin',
            '--stdin-filename',
            function() return vim.api.nvim_buf_get_name(0) end,
        }

        vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
            group = vim.api.nvim_create_augroup('RestartEslint', { clear = true }),
            pattern = '*eslint*',
            callback = function()
                vim.fn.system('eslint_d restart')
                require('core.toggles').notify('eslint_d restarted due to config change')
            end,
        })

        vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave', 'BufEnter' }, {
            group = vim.api.nvim_create_augroup('LintZsh', { clear = true }),
            pattern = { '*.zsh', '.zshrc', '.zshenv', '.zprofile' },
            callback = function() require('lint').try_lint() end,
        })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
            group = vim.api.nvim_create_augroup('StartLinting', { clear = true }),
            callback = function() lint.try_lint() end,
        })
    end,
}
