function OverrideColors(color)
    color = color or "nord"
    vim.cmd.colorscheme(color)

    -- Override colors here
    -- Example: Transparent background (i.e. use terminal default)
    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

OverrideColors()
