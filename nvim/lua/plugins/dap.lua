-- gdb 14+ speaks DAP natively: no codelldb/mason download needed
return {
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }
      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            name = "Launch (gdb)",
            type = "gdb",
            request = "launch",
            program = function()
              return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
          },
          {
            name = "Attach to PID (gdb)",
            type = "gdb",
            request = "attach",
            pid = function()
              return tonumber(vim.fn.input("PID: "))
            end,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
