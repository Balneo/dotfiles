local function run_current_file()
  local file = vim.fn.expand("%:p")
  if file == "" then
    vim.notify("No file to run", vim.log.levels.WARN)
    return
  end

  local ft = vim.bo.filetype
  local cmd

  if ft == "python" then
    cmd = "python3 " .. file
  elseif ft == "bash" or ft == "sh" then
    cmd = "bash " .. file
  elseif ft == "lua" then
    cmd = "lua " .. file
  elseif ft == "javascript" then
    cmd = "node " .. file
  else
    vim.notify("No runner for filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  vim.cmd("split | resize 15 | terminal " .. cmd)
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>rf", run_current_file, {
  desc = "Run current file in terminal",
})
