return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',

    config = function()
        local ts = require('nvim-treesitter')

        local function start(b, p)
            vim.treesitter.start(b, p)
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldlevel = 99
        end

        ts.install({
            'javascript',
            'typescript',
            'rust',
            'python',
            'bash',
            'markdown',
            'markdown_inline',
            'json',
            'diff',
            'lua',
            'vimdoc',
            'sql',
        })

        vim.api.nvim_create_autocmd('FileType', {
            pattern = '*',
            callback = function(e)
                local ft, buf = e.match, e.buf
                if ft == '' then return end

                local parser = vim.treesitter.language.get_lang(ft) or ft
                if not parser then return end

                if not vim.tbl_contains(ts.get_available(), parser) then return end

                local installed = ts.get_installed()
                if not vim.tbl_contains(installed, parser) then
                    ts.install({ parser }):await(function() start(buf, parser) end)
                    return
                end

                start(buf, parser)
            end,
        })

        vim.o.foldtext = ''
        vim.o.foldlevelstart = 99
    end,
}
