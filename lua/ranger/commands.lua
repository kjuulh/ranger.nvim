local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Ranger", function() require("ranger.actions").ranger() end, {})
end

return M
