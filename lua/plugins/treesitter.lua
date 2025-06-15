return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    config = function()
        require('nvim-treesitter.install').prefer_git = true

        require('nvim-treesitter.configs').setup({
            highlight = {
                enable = true,
                disable = function(_, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then return true end
                end,
            },
            indent = { enable = false },
            autotag = { enable = false },
            auto_install = true,
            rainbow = { enable = true, max_file_lines = 1000 },
            textobject = { enable = false },
            playground = { enable = false },
        })
    end,
}
