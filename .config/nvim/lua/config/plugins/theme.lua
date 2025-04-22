return {
    { "nvim-tree/nvim-web-devicons" },
    {
        "folke/tokyonight.nvim",
        config = function()
            vim.cmd.colorscheme "tokyonight"
        end
    },
    --{ "shaunsingh/nord.nvim", config = function() vim.cmd.colorscheme "nord" end },
    {
        "xiyaowong/transparent.nvim",
        lazy = false,
        config = {
            extra_groups = {
                "FloatBorder",
                "LSPInfoBorder",
                "NeoTreeNormal",
                "NeoTreeNormalNC",
                "NormalFloat",
                "NotifyDEBUGBody",
                "NotifyDEBUGBorder",
                "NotifyERRORBody",
                "NotifyERRORBorder",
                "NotifyINFOBody",
                "NotifyINFOBorder",
                "NotifyTRACEBody",
                "NotifyTRACEBorder",
                "NotifyWARNBody",
                "NotifyWARNBorder",
                "TelescopeBorder",
                "TelescopePreviewNormal",
                "TelescopePromptNormal",
                "TelescopeResultsNormal",
                "WhichKeyFloat",
            },
            exclude_groups = {},
        },
        keys = {
            {
                "<Leader>ut",
                "<Cmd>TransparentToggle<Cr>",
                desc = "Toggle Transparency",
            },
        },
    },
}
