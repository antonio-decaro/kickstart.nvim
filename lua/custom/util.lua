local M = {}

function M.map(mode, lhs, rhs, opts)
  opts = opts or {}
  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

return M
