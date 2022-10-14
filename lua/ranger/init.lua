RANGER_BUFFER = nil
RANGER_LOADED = false
vim.g.ranger_opened = 0
vim.g.ranger_floating_window_winblend = 0
vim.g.ranger_floating_window_scaling_factor = 0.9

local M = {}

function M.setup(options) require("ranger.commands").setup() end

return M
