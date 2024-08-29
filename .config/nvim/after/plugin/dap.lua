local dap = require("dap")
local dapui = require("dapui.init")
local daptext = require("nvim-dap-virtual-text")
dapui.setup()
daptext.setup()

-- dap.listeners.after.event_initialized["dapui_config"] = function()
--     dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
--     dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
--     dapui.close()
-- end

dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    --dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    --dapui.close()
end