return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = function()
      local session_dir = vim.fn.expand '~/.local/share/nvim-session'
      if vim.fn.isdirectory(session_dir) == 0 then session_dir = vim.fn.expand '~/.local/share/nvim-sessions' end
      local sessions = {}

      for _, path in ipairs(vim.fn.globpath(session_dir, '*', false, true)) do
        local name = vim.fn.fnamemodify(path, ':t')
        if name ~= '' then table.insert(sessions, name) end
      end

      table.sort(sessions)

      local center = {
        {
          action = function() require('telescope.builtin').find_files() end,
          desc = ' Find File',
          icon = ' ',
          key = 'f',
        },
        { action = 'ene | startinsert', desc = ' New File', icon = ' ', key = 'n' },
        {
          action = function() require('telescope.builtin').oldfiles() end,
          desc = ' Recent Files',
          icon = ' ',
          key = 'r',
        },
        {
          action = function() require('telescope.builtin').live_grep() end,
          desc = ' Find Text',
          icon = ' ',
          key = 'g',
        },
        {
          action = function() require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' } end,
          desc = ' Config',
          icon = ' ',
          key = 'c',
        },
        {
          action = function()
            require('mini.sessions').select()
            pcall(vim.cmd, 'Neotree close')
          end,
          desc = ' Select Session',
          icon = ' ',
          key = 's',
        },
        { action = 'Lazy', desc = ' Plugin Manager', icon = '󰒲 ', key = 'l' },
      }

      for i, name in ipairs(sessions) do
        if i > 5 then break end
        table.insert(center, {
          action = function()
            require('mini.sessions').read(name)
            pcall(vim.cmd, 'Neotree close')
          end,
          desc = ' Session: ' .. name,
          icon = '󱂬 ',
          key = tostring(i),
        })
      end

      table.insert(center, {
        action = function() vim.api.nvim_input '<cmd>qa<cr>' end,
        desc = ' Quit',
        icon = ' ',
        key = 'q',
      })

      return {
        theme = 'doom',
        config = {
          hide = {
            statusline = false,
          },

          center = center,

          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }
    end,
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
      keymap('n', '<C-d>', function() neoscroll.scroll(0.1, { move_cursor = true, duration = 120 }) end, { desc = 'Scroll down (smooth)' })
      keymap('n', '<C-u>', function() neoscroll.scroll(-0.1, { move_cursor = true, duration = 120 }) end, { desc = 'Scroll up (smooth)' })
      keymap('n', '<PageDown>', function() neoscroll.scroll(vim.wo.scroll, { move_cursor = true, duration = 350 }) end, { desc = 'Scroll Page Down' })
      keymap('n', '<PageUp>', function() neoscroll.scroll(-vim.wo.scroll, { move_cursor = true, duration = 350 }) end, { desc = 'Scroll Page Down' })
    end,
  },
}
