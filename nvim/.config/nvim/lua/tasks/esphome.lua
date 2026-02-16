local overseer = require("overseer")

overseer.register_template({
  name = "ESPHome: Run & Flash (Auto Serial → OTA)",
  -- desc = "Use serial if connected, otherwise fall back to OTA",
  condition = {
    file = "weather-node.yaml",
  },

  params = {
    file = {
      type = "string",
      default = "weather-node.yaml",
    },
  },

  builder = function(params)
    local args = {
      "exec",
      "esphome",
      "esphome",
      "run",
      params.file,
    }

    -- Detect serial device
    local serial = vim.fn.glob("/dev/ttyUSB*")
    if serial ~= "" then
      table.insert(args, "--device")
      table.insert(args, serial)
    end

    -- Always include OTA fallback
    table.insert(args, "--device")
    table.insert(args, "weather-node.local")

    return {
      cmd = { "docker-compose" },
      args = args,
      components = {
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
})
