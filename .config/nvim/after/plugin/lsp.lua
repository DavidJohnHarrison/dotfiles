local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
cmp.setup({
    completion = {
        completeopt = "menu,menuone,preview,noselect",
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    -- window = {
    --     completion = cmp.config.window.bordered(),
    --     documentation = cmp.config.window.bordered(),
    -- },
    mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})


local language_servers = {
    'pyright',
    'lua_ls',
    'clangd',
    'html',
    'cssls',
    'tsserver',
}


require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = language_servers,
    automatic_installation = true,
})




local lsp_config = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local capabilities = cmp_nvim_lsp.default_capabilities()

local on_attach = function(client, bufnr)
end

local setup_config = {}
for _,v in pairs(language_servers) do
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
    lsp_config[language_server].setup(config)
end

