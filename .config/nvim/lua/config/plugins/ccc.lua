return {
    {
        "uga-rosa/ccc.nvim",
        config = function()
            local ccc = require("ccc")
            local mapping = ccc.mapping

            ccc.setup({
              -- Your preferred settings
              -- Example: enable highlighter
              highlighter = {
                auto_enable = true,
                lsp = true,
              },
            })
            vim.api.nvim_set_keymap("n", "<leader>c", ":CccPick<CR>", {})
        end
    }
}
