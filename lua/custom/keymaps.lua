local util = require 'custom.util'

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
util.map('n', '<Esc>', '<cmd>nohlsearch<CR>')

util.map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode

util.map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- util.map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- util.map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- util.map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- util.map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands

-- util.map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- util.map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- util.map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- util.map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

util.map('n', '<leader>Ss', function()
  MiniSessions.select()
  pcall(vim.cmd, 'Neotree close')
end, { desc = 'Select session to load' })
util.map('n', '<leader>Sw', function()
  local cwd = vim.fn.getcwd()
  local session_name = vim.fn.fnamemodify(cwd, ':t')
  vim.ui.input({ prompt = 'Session name: ', default = session_name }, function(name)
    if name == nil then
      vim.notify 'Session save cancelled'
      return
    end
    if name == '' then name = session_name end
    pcall(vim.cmd, 'Neotree close')
    MiniSessions.write(name)
    vim.notify('Session saved as ' .. name)
  end)
end, { desc = 'Write current session' })
util.map('n', '<leader>Sd', function() MiniSessions.delete(nil, { force = true }) end, { desc = 'Delete current session' })
