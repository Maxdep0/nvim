-- stylua: ignore
return {
    'folke/flash.nvim',
    event = 'VeryLazy',

    opts = {},

    keys = {
        { 's',     mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,               desc = 'Flash: Open flash', },
        { 'S',     mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end,         desc = 'Flash: Open flash in treesitter mode', },
        { 'r',     mode = 'o',               function() require('flash').remote() end,             desc = 'Flash: Open flash in remove mode', },
        { 'R',     mode = { 'o', 'x' },      function() require('flash').treesitter_search() end,  desc = 'Flash: Open flash in treesitter search mode', },
        { '<c-s>', mode = { 'c' },           function() require('flash').toggle() end,             desc = 'Flash: Toggle flash while using regular search', },
    },
}
