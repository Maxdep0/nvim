return {
    cmd = { 'pylsp' },
    filetypes = { 'python' },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { enabled = false },
                pyflakes = { enabled = false },
                mccabe = { enabled = false },
                yaplf = { enabled = false },
            },
        },
    },
}

