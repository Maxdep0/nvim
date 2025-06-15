return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        signs = false,
        sign_priority = 8,
        keywords = {
            BUG = { color = '#DC143C', alt = { 'BUG', 'ISSUE', 'FIXIT' } },
            TODO = { color = '#FF4500', alt = { 'TODO' } },
            DONE = { color = '#32CD32', alt = { 'DONE' } },
            CRIT = { color = '#B22222' },
            WARN = { color = '#FFA500' },
            PERF = { color = '#1E90FF', alt = { 'OPTIMIZE', 'PERFORMANCE' } },
            NOTE = { color = '#FFD700', alt = { 'INFO', 'IDEA' } },
            TEST = { color = '#FF69B4' },
            REFACTOR = { color = '#FFD700', alt = { 'CLEANUP', 'IMPROVE' } },
            DEBUG = { color = '#A020F0', alt = { 'LOG', 'TRACE' } },
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
