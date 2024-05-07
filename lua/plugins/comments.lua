return {
    'numToStr/Comment.nvim',
    cond = true,

    config = function()
        require('Comment').setup()
    end,
}
