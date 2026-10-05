return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                kotlin_language_server = { enabled = false },
                kotlin_lsp = {
                    cmd = { "kotlin-lsp", "--stdio" },
                    single_file_support = false,
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            format = {
                                enable = false,
                            },
                        },
                    },
                },
            },
        },
    },
}
