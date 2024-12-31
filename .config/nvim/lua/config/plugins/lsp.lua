local language_servers = {
    'pyright',
    'ruff',
    'lua_ls',
    'clangd',
    'omnisharp',
    'html',
    'cssls',
    'ts_ls',
    'texlab',
}


return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            --{
            --    "folke/lazydev.nvim",
            --    ft = "lua",
            --    opts = {
            --        library = {
            --            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            --        },
            --    },
            --},
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = language_servers,
                automatic_installation = true,
            })

            local lspconfig = require("lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local capabilities = cmp_nvim_lsp.default_capabilities()

            local on_attach = function(client, bufnr)
            end

            local setup_config = {}
            for _, v in pairs(language_servers) do
                setup_config[v] = {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }
            end


            setup_config["lua_ls"].settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            }

            for language_server, config in pairs(setup_config) do
                lspconfig[language_server].setup(config)
            end

            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            vim.keymap.set("n", "grn", vim.lsp.buf.rename)
            vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action)
            vim.keymap.set("n", "grr", vim.lsp.buf.references)
            vim.keymap.set("n", "gri", vim.lsp.buf.document_symbol)
            vim.keymap.set("i", "<C-S>", vim.lsp.buf.signature_help)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition)

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then return end

                    if client.supports_method("textDocument/formatting") then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                            end,
                        })
                    end
                end
            })
        end

    }
}
