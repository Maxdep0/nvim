--Enable (broadcasting) snippet capability for completion
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
    -- capabilities = capabilities,
    cmd = { 'vscode-html-language-server', '--stdio' },
    init_options = {
        configurationSection = { 'html', 'css', 'javascript' },
        embeddedLanguages = {
            css = true,
            javascript = true,
        },
        provideFormatter = true,
    },
}
