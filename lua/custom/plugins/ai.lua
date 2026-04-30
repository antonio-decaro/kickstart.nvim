return {
  -- Claude Code
  {
    'coder/claudecode.nvim',
    dependencies = { 'folke/snacks.nvim' },
    config = true,
    keys = {
      { '<leader>c', nil, desc = 'AI/Claude Code' },
      { '<leader>cc', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
      { '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
      { '<leader>cr', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
      { '<leader>cC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
      { '<leader>cm', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
      { '<leader>cb', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
      { '<leader>cs', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
      {
        '<leader>cs',
        '<cmd>ClaudeCodeTreeAdd<cr>',
        desc = 'Add file',
        ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
      },
      -- Diff management
      { '<leader>ca', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
      { '<leader>cd', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    },
  },
  -- Codex
  -- {
  --   'kkrampis/codex.nvim',
  --   lazy = true,
  --   cmd = { 'Codex', 'CodexToggle' }, -- Optional: Load only on command execution
  --   keys = {
  --     {
  --       '<leader>cc', -- Change this to your preferred keybinding
  --       function() require('codex').toggle() end,
  --       desc = 'Toggle Codex popup or side-panel',
  --       mode = { 'n', 't' },
  --     },
  --   },
  --   opts = {
  --     keymaps = {
  --       toggle = '<leader>c', -- Keybind to toggle Codex window (Disabled by default, watch out for conflicts)
  --       quit = '<C-d>', -- Keybind to close the Codex window (default: Ctrl + q)
  --     }, -- Disable internal default keymap (<leader>cc -> :CodexToggle)
  --     border = 'rounded', -- Options: 'single', 'double', or 'rounded'
  --     width = 0.8, -- Width of the floating window (0.0 to 1.0)
  --     height = 0.8, -- Height of the floating window (0.0 to 1.0)
  --     model = nil, -- Optional: pass a string to use a specific model (e.g., 'o3-mini')
  --     autoinstall = true, -- Automatically install the Codex CLI if not found
  --     panel = false, -- Open Codex in a side-panel (vertical split) instead of floating window
  --     use_buffer = false, -- Capture Codex stdout into a normal buffer instead of a terminal buffer
  --   },
  -- },

  { -- Setup GitHub Copilot for AI code suggestions
    'github/copilot.vim',
    cmd = 'Copilot',
    event = 'InsertEnter',
  },
}
