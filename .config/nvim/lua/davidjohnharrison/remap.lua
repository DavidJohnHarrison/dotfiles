vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- ==== EASY INSERT HEADINGS =======================================================================
-- -- Config ---------------------------------------------------------------------------------------
local heading_command_prefix = "<C-h>"
local heading_types = {"=", "-", "*", "!"}
local heading_type_main = "="
local heading_type_sub = "-"
-- -------------------------------------------------------------------------------------------------

-- -- Helper Functions -----------------------------------------------------------------------------
local get_command_normal = function(heading_type)
    return string.format("100A%s<esc>d100|^f%s4lR ", heading_type, heading_type)
end
local get_command_insert = function(heading_type)
    return string.format("<esc>%s", get_command_normal(heading_type))
end
-- -------------------------------------------------------------------------------------------------

-- -- Mappings -------------------------------------------------------------------------------------
local params = {noremap=true, silent=true}

-- Map all heading types
for _, heading_type in ipairs(heading_types) do
    local heading_command = string.format("%s%s", heading_command_prefix, heading_type)
    vim.api.nvim_set_keymap("n", heading_command, get_command_normal(heading_type), params)
    vim.api.nvim_set_keymap("i", heading_command, get_command_insert(heading_type), params)
end
-- Map 'main' heading type (main and sub)
vim.api.nvim_set_keymap("n",
                        string.format("%sH", heading_command_prefix),
                        get_command_normal(heading_type_main),
                        params)
vim.api.nvim_set_keymap("i",
                        string.format("%sH", heading_command_prefix),
                        get_command_insert(heading_type_main),
                        params)
-- Map 'main' heading type (main and sub)
vim.api.nvim_set_keymap("n",
                        string.format("%sh", heading_command_prefix),
                        get_command_normal(heading_type_sub),
                        params)
vim.api.nvim_set_keymap("i",
                        string.format("%sh", heading_command_prefix),
                        get_command_insert(heading_type_sub),
                        params)
-- -------------------------------------------------------------------------------------------------
-- =================================================================================================

