return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        signs = false,
        sign_priority = 8,
        keywords = {

            TODO = { color = '#FF8C00', alt = { 'TODO', 'TASK' } },
            PROGRESS = { color = '#00CED1', alt = { 'WORKING', 'WIP' } },
            DONE = { color = '#00FF00', alt = { 'DONE' } },

            INFO = { color = '#87CEEB', alt = { 'INFO', 'NOTE', 'IDEA' } },
            WARN = { color = '#FFD700', alt = { 'WARN', 'WARNING' } },
            ERROR = { color = '#FF0000', alt = { 'ERR', 'ERROR' } },
            BUG = { color = '#FF6347', alt = { 'BUG', 'FIXIT', 'FIXME' } },
            CRIT = { color = '#8B0000', alt = { 'CRIT', 'CRITICAL' } },

            TEST = { color = '#FF69B4', alt = { 'TEST', 'TESTING', 'PASSED', 'FAILED' } },
            REFACTOR = { color = '#9370DB', alt = { 'REFACTOR', 'CLEANUP', 'IMPROVE' } },
            PERFORMANCE = { color = '#1E90FF', alt = { 'PERF', 'OPTIMIZE', 'PERFORMANCE' } },
            QUESTION = { color = '#FF1493', alt = { 'QUESTION', 'REVIEW', 'CHECK', 'WHAT' } },

            HACK = { color = '#FFA500', alt = { 'HACK', 'XXX', 'TEMP', 'WORKAROUND' } },
            DEPRECATED = { color = '#808080', alt = { 'DEPRECATED', 'OBSOLETE', 'OLD' } },
            DOCS = { color = '#4682B4', alt = { 'DOCS', 'DOCUMENTATION', 'README' } },

            RG = { color = '#808080', alt = { 'RG' } },
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
