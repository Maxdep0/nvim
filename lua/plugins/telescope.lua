-- https://github.com/BurntSushi/ripgrep
-- https://github.com/niXman/mingw-builds-binaries
-- https://github.com/sharkdp/fd

return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',

            -- Windows: https://github.com/niXman/mingw-builds-binaries
            -- Create a copy of mingw64/bin/mingw32-make.exe and name it make.exe or use build = 'mingw32-make'
            -- https://github.com/nvim-telescope/telescope-fzf-native.nvim?tab=readme-ov-file#installation
            -- https://www.reddit.com/r/neovim/comments/10nzgdx/im_trying_to_set_up_telescope_with_fzfnative_and/
            build = 'mingw32-make',
        },
        {
            'nvim-tree/nvim-web-devicons',
            enabled = vim.g.have_nerd_font,
        },
    },
    config = function()
        local builtin = require('telescope.builtin')

        require('telescope').setup({
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
            },
        })

        -- require('telescope').load_extension('fzf')
        local ok = pcall(require('telescope').load_extension, 'fzf')

        if not ok then
            print('Failed to load telescope-fzf-native.nvim')
        end

        local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { desc = 'Search: ' .. desc })
        end

        map('<leader><space>', builtin.find_files, 'Search Files')
        map('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
        map('<leader>sp', builtin.git_files, '[S]earch Git [P]roject  Files')
        map('<leader>sb', builtin.buffers, '[S]earch for existing [B]uffers')

        map('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
        map('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
        map('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
        map('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')

        map('<leader>sn', function()
            builtin.find_files({ cwd = vim.fn.stdpath('config') })
        end, '[S]earch [N]eovim files')
    end,
}
