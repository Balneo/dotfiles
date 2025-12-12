local state_file = vim.fn.stdpath("state") .. "/last_colorscheme.txt"

-- Restore last theme on startup
if vim.fn.filereadable(state_file) == 1 then
    local scheme = vim.fn.readfile(state_file)[1]
    pcall(vim.cmd.colorscheme, scheme)
end

-- Save chosen theme whenever you change it
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        local scheme = vim.g.colors_name
        vim.fn.writefile({ scheme }, state_file)
    end,
})
