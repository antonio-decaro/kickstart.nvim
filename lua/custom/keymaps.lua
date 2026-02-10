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

util.map('n', '<M-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
util.map('n', '<M-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
util.map('n', '<M-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
util.map('n', '<M-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
