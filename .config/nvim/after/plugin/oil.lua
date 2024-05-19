local oil = require("oil")
oil.setup({
    default_file_explorer = false,
    view_options = {
        show_hidden = true,
    },
})

vim.keymap.set('n', '<leader>\\', oil.toggle_float)
