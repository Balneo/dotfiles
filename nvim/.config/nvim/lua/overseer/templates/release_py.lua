return {
    name = "Run release.py",
    desc = "Run release.py with input/output/work dirs",
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
            "script.py",
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
}

