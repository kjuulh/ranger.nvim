local prev_win = -1

local function on_exit(job_id, code, event)
  if code ~= 0 then return end

  vim.cmd "silent! :q"
  RANGER_BUFFER = nil
  RANGER_LOADED = false
  vim.g.ranger_opened = 0
  vim.cmd "silent! :checktime"

  if vim.fn.filereadable "/tmp/ranger-choose" then
    for _, f in pairs(vim.fn.readfile "/tmp/ranger-choose") do
      vim.cmd(string.format("silent! :edit %s", f))
      return
    end
    vim.cmd [[call delete("/tmp/ranger-choose")]]
  end
end

local function exec_ranger_command(cmd)
  if RANGER_LOADED == false then
    vim.g.ranger_opened = 1
    vim.fn.termopen(cmd, { on_exit = on_exit })
  end
  vim.cmd "silent! :startinsert"
end

local M = {}

function M.ranger()
  prev_win = vim.api.nvim_get_current_win

  require("ranger.floating").open_floating_window()

  local cmd = "ranger"

  cmd = string.format("%s --choosefiles=%s %s", cmd, "/tmp/ranger-choose", vim.fn.expand "%")

  exec_ranger_command(cmd)
end

return M
