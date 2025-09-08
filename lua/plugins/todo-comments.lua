return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        signs = false,
        sign_priority = 8,
        keywords = {
            -- stylua: ignore start
            TODO        = { color = vim.g.base16_todo.todo        or '#FF8C00', alt = { 'TODO', 'TASK', 'FIXIT' } },
            INFO        = { color = vim.g.base16_todo.info        or '#87CEEB', alt = { 'INFO', 'NOTE', 'IDEA' } },
            ERROR       = { color = vim.g.base16_todo.error       or '#FF0000', alt = { 'ERR',  'ERROR' } },
            WARN        = { color = vim.g.base16_todo.warn        or '#FFD700', alt = { 'WARN', 'WARNING' } },
            BUG         = { color = vim.g.base16_todo.bug         or '#FF6347', alt = { 'BUG',  'FIXIT' } },
            PERFORMANCE = { color = vim.g.base16_todo.performance or '#1E90FF', alt = { 'PERF', 'OPTIMIZE', 'PERFORMANCE' }, },
            TEST        = { color = vim.g.base16_todo.test        or '#FF69B4', alt = { 'TEST', 'TESTING', 'PASSED', 'FAILED' } },
            HACK        = { color = vim.g.base16_todo.hack        or '#FFA500', alt = { 'HACK', 'XXX', 'TEMP', 'WORKAROUND' } },
            -- stylua: ignore end
        },

        gui_style = { fg = 'NONE', bg = 'BOLD' },
        merge_keywords = true,
        highlight = {
            multiline = false,
            multiline_pattern = '^.',
            multiline_context = 10,
            before = '',
            keyword = 'wide',
            after = 'fg',
            pattern = [[.*<(KEYWORDS)\s*:]],
            comments_only = true,
            max_line_len = 400,
            exclude = {},
        },

        search = {
            command = 'rg',
            args = { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column' },
            pattern = [[\b(KEYWORDS):]],
        },
    },
}
