return {
    {
        "mfussenegger/nvim-dap-python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dap_python = require("dap-python")
            local dap_ui = require("dapui.init")
            local dap_text = require("nvim-dap-virtual-text")
            dap_python.setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
            dap_ui.setup()
            dap_text.setup()


            -- dap.listeners.after.event_initialized["dap_ui_config"] = function()
            --     dap_ui.open()
            -- end
            -- dap.listeners.before.event_terminated["dap_ui_config"] = function()
            --     dap_ui.close()
            -- end
            -- dap.listeners.before.event_exited["dap_ui_config"] = function()
            --     dap_ui.close()
            -- end

            dap.listeners.before.attach.dap_ui_config = function()
                dap_ui.open()
            end
            dap.listeners.before.launch.dap_ui_config = function()
                dap_ui.open()
            end
            dap.listeners.before.event_terminated.dap_ui_config = function()
                --dap_ui.close()
            end
            dap.listeners.before.event_exited.dap_ui_config = function()
                --dap_ui.close()
            end

            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<F1>", dap.continue)
            vim.keymap.set("n", "<F2>", dap.run_to_cursor)
            vim.api.nvim_set_keymap("n", "<F3>", ":lua require('dap-python').test_method()\n", {})

            vim.keymap.set("n", "<F5>", dap.step_over)
            vim.keymap.set("n", "<F6>", dap.step_into)
            vim.keymap.set("n", "<F4>", dap.step_out)
            vim.keymap.set("n", "<F8>", dap.step_back)
            vim.keymap.set("n", "<F9>", dap.restart)
            vim.keymap.set("n", "<leader>dc", dap.terminate)

            vim.keymap.set("n", "<F11>", dap_ui.open)
            vim.keymap.set("n", "<F12>", dap_ui.close)


            vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
            vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })
        end
    }
}
