local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

local opts = {

    change_detection = { enabled = false, notify = true },

    -- ui = {
    --     icons = vim.g.have_nerd_font and {} or {
    --         cmd = '⌘',
    --         config = '🛠',
    --         event = '📅',
    --         ft = '📂',
    --         init = '⚙',
    --         keys = '🗝',
    --         plugin = '🔌',
    --         runtime = '💻',
    --         require = '🌙',
    --         source = '📄',
    --         start = '🚀',
    --         task = '📌',
    --         lazy = '💤 ',
    --     },
    -- },
}

require('lazy').setup('plugins', opts)
