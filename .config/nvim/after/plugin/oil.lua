local oil = require("oil")
oil.setup({
    default_file_explorer = false,
})

--vim.keymap.set('n', '<leader>R', oil.toggle_float)
vim.keymap.set('n', '<leader>|', oil.toggle_float)
