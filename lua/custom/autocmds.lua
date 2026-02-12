local util = require 'custom.util'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = util.augroup 'kickstart-highlight-yank',
  callback = function() vim.hl.on_yank() end,
})

local function wezterm_set_user_var(name, value)
  -- OSC 1337 SetUserVar (WezTerm supports this)
  -- name/value must be base64
  local b64 = vim.base64.encode(value)
  io.write(string.format('\x1b]1337;SetUserVar=%s=%s\x07', name, b64))
end

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function() wezterm_set_user_var('IS_NVIM', '1') end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  callback = function() wezterm_set_user_var('IS_NVIM', '0') end,
})
