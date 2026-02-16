local overseer = require("overseer")

overseer.register_template({
  name = "Pytest: Current File",
  condition = {
    filetype = { "python" },
  },
  builder = function()
    local file = vim.api.nvim_buf_get_name(0)
    local root = get_root()

    return {
      cmd = { "poetry", "run", "pytest", file, "-v" },
      cwd = root,
      components = {
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
})

overseer.register_template({
  name = "Python: Ruff Fix + Lint",
  condition = {
    callback = is_python_project,
  },
  builder = function()
    local root = get_root()

    return {
      cmd = {
        "sh",
        "-c",
        "poetry run ruff check . --fix && poetry run ruff check .",
      },
      cwd = root,
      components = {
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
})
overseer.register_template({
    name = "Run release.py",
    desc = "Run release.py with input/output/work dirs",
    condition = {
        callback = is_python_project,
    },
    params = {
        input = {
            type = "string",
            desc = "Input directory",
            default = ".",
        },
        output = {
            type = "string",
            desc = "Output directory",
            default = "../tmp/output",
        },
        work = {
            type = "string",
            desc = "Work directory",
            default = "../tmp/work",
        },
        debug = {
            type = "boolean",
            default = false,
        },
        clean = {
            type = "boolean",
            default = false,
        },
    },
    builder = function(params)
        local cmd = {
            "python3",
            "release.py",
            "-i", params.input,
            "-o", params.output,
            "-w", params.work,
        }

        if params.debug then table.insert(cmd, "--debug") end
        if params.clean then table.insert(cmd, "--clean") end

        return {
            cmd = cmd,
            components = {
                "default",
                { "on_output_quickfix", open = true },
            },
        }
    end,
})

