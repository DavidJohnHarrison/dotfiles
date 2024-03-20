--nvim_tree = require("nvim-tree")

--local function on_attach(bufnr)
--    local api = require("nvim-tree.api")
--local function opts(desc)
--    return {
--        desc = "nvim-tree: " .. desc,
--        buffer = bufnr,
--        noremap = true,
--        silent = true,
--        nowait = true
--    }
--end

--    --vim.keymap.set("n", "<leader>t", ":NvimTreeToggle")
--    vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle")
--end
--
--nvim_tree.setup({
--    on_attach = on_attach,
--    filters = {
--        dotfiles = true,
--    }
--})
--


-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
--require("nvim-tree").setup()

-- OR setup with some options
--require("nvim-tree").setup({
--  sort = {
--    sorter = "case_sensitive",
--  },
--  view = {
--    width = 30,
--  },
--  renderer = {
--    group_empty = true,
--  },
--  filters = {
--    dotfiles = true,
--  },
--})


local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
    on_attach = my_on_attach,
    filters = {
        dotfiles = false,
        custom = {
            ".git",
            "node_modules",
            "venv"
        },
    },
}

--vim.keymap.set("n", "<leader>pv", vim.cmd.NvimTreeToggle)
--vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<leader>r", vim.cmd.NvimTreeToggle)
