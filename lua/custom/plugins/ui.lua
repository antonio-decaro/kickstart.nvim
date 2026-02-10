return {
  { -- A nice dashboard when you open Neovim
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  },
  { -- Display a nice notification when you save a file
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  { -- A nice cursor trail effect
    'sphamba/smear-cursor.nvim',
    opts = {
      opts = {
        stiffness = 0.5,
        trailing_stiffness = 0.5,
        matrix_pixel_threshold = 0.5,
      },
    },
  },
  {
    'karb94/neoscroll.nvim',
    opts = {
      mappings = { -- Keys to be mapped to their corresponding default scrolling animation
        'zt',
        'zz',
        'zb',
        '<C-u>',
        '<C-d>',
      },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      duration_multiplier = 1.0,
      easing = 'linear',
      pre_hook = nil,
      post_hook = nil,
      performance_mode = false,
      ignored_events = {
        'WinScrolled',
        'CursorMoved',
      },
    },
    config = function(_, opts)
      require('neoscroll').setup(opts)
      local neoscroll = require 'neoscroll'
      local keymap = vim.keymap.set

      -- On many terminals <C-j> is seen as <NL>, so map both:
      keymap('n', '<C-j>', function() neoscroll.scroll(0.1, { move_cursor = true, duration = 120 }) end, { desc = 'Scroll down (smooth)' })
      keymap('n', '<C-k>', function() neoscroll.scroll(-0.1, { move_cursor = true, duration = 120 }) end, { desc = 'Scroll up (smooth)' })
      keymap('n', '<PageDown', function() neoscroll.scroll(vim.wo.scroll, { move_cursor = true, duration = 350 }) end, { desc = 'Scroll Page Down' })
      keymap('n', '<PageUp', function() neoscroll.scroll(-vim.wo.scroll, { move_cursor = true, duration = 350 }) end, { desc = 'Scroll Page Down' })
    end,
  },
}
