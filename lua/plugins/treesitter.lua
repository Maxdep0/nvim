return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    config = function()
        require('nvim-treesitter.install').prefer_git = true

        require('nvim-treesitter.configs').setup({
            auto_install = true,
            indent = { enable = false },
            autotag = { enable = true },
            rainbow = { enable = false },
            textobject = { enable = false },
            playground = { enable = false },
            highlight = {
                enable = true,
                disable = function(_, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then return true end
                end,
                additional_vim_regex_highlighting = false,
            },
            ensure_installed = {
                'css',
                'scss',
                'html',
                'json',
                'lua',
                'luadoc',
                'vim',
                'vimdoc',
                'javascript',
                'typescript',
                'markdown',
                'gitignore',
                'python',
                'toml',
                'markdown',
                'bash',
            },
        })
    end,
}
