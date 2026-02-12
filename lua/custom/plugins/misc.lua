-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'Vigemus/iron.nvim' },

  {
    'hat0uma/csvview.nvim',
    opts = {
      parser = { comments = { '#', '//' } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { 'if', mode = { 'o', 'x' } },
        textobject_field_outer = { 'af', mode = { 'o', 'x' } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
        jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
        jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
        jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
      },
    },
    cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
  },
  {
    'mrjones2014/smart-splits.nvim',
    config = function()
      local is_ssh = (vim.env.SSH_CONNECTION ~= nil) or (vim.env.SSH_TTY ~= nil)

      require('smart-splits').setup {
        multiplexer_integration = is_ssh and 'tmux' or 'wezterm',
      }

      local ss = require 'smart-splits'

      vim.keymap.set('n', '<C-h>', ss.move_cursor_left, { desc = 'Move left (nvim/wezterm)' })
      vim.keymap.set('n', '<C-j>', ss.move_cursor_down, { desc = 'Move down (nvim/wezterm)' })
      vim.keymap.set('n', '<C-k>', ss.move_cursor_up, { desc = 'Move up (nvim/wezterm)' })
      vim.keymap.set('n', '<C-l>', ss.move_cursor_right, { desc = 'Move right (nvim/wezterm)' })
      vim.keymap.set('n', '<A-h>', ss.resize_left, { desc = 'Resize left (nvim/wezterm)' })
      vim.keymap.set('n', '<A-j>', ss.resize_down, { desc = 'Resize down (nvim/wezterm)' })
      vim.keymap.set('n', '<A-k>', ss.resize_up, { desc = 'Resize up (nvim/wezterm)' })
      vim.keymap.set('n', '<A-l>', ss.resize_right, { desc = 'Resize right (nvim/wezterm)' })
    end,
  },
}
