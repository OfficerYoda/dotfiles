return {
    {
        "neovim/nvim-lspconfig",
        opts = {
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
}
