return {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        signs = false,
        sign_priority = 8,
        keywords = {
            BUG = { color = '#DC143C', alt = { 'BUG', 'ISSUE', 'FIXIT' } }, -- crimson for bug
            TODO = { color = '#FF4500', alt = { 'TODO' } }, -- bright red-orange
            DONE = { color = '#32CD32', alt = { 'DONE' } }, -- lime green
            CRIT = { color = '#B22222' }, -- firebrick red for critical
            WARN = { color = '#FFA500' }, -- orange warning
            PERF = { color = '#1E90FF', alt = { 'OPTIMIZE', 'PERFORMANCE' } }, -- dodger blue
            NOTE = { color = '#FFD700', alt = { 'INFO', 'IDEA' } }, -- golden yellow
            TEST = { color = '#FF69B4' }, -- hot pink for testing
            REFACTOR = { color = '#FFD700', alt = { 'CLEANUP', 'IMPROVE' } }, -- golden yellow for refactor
            DEBUG = { color = '#A020F0', alt = { 'LOG', 'TRACE' } }, -- purple for debug
        },
        -- keywords = {
        --     BUG = { color = 'error', alt = { 'BUG', 'ISSUE', 'FIXIT' } },
        --     TODO = { color = '#FF0000', alt = { 'TODO' } },
        --     DONE = { color = 'chore', alt = { 'DONE' } },
        --     CRIT = { color = '#FF0000' },
        --     WARN = { color = 'warning' },
        --     PERF = { color = 'hint', alt = { 'OPTIMIZE', 'PERFORMANCE' } },
        --     NOTE = { color = 'hint', alt = { 'INFO', 'IDEA' } },
        --     TEST = { color = 'test' },
        --     REFACTOR = { color = 'refactor', alt = { 'CLEANUP', 'IMPROVE' } },
        --     DEBUG = { color = 'debug', alt = { 'LOG', 'TRACE' } },
        -- },

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
