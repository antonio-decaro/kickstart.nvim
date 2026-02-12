return {
  { -- A nice dashboard when you open Neovim
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      local displayed_sessions = {}

      local function get_recent_sessions(limit)
        local sessions_dir = vim.fn.expand '~/.local/share/nvim-sessions'
        local session_files = vim.fn.globpath(sessions_dir, '*', false, true)
        local sessions = {}

        table.sort(session_files, function(a, b) return vim.fn.getftime(a) > vim.fn.getftime(b) end)

        for _, file in ipairs(session_files) do
          if vim.fn.filereadable(file) == 1 then
            local session_name = vim.fn.fnamemodify(file, ':t'):gsub('%.vim$', '')
            sessions[#sessions + 1] = { name = session_name, file = file }
            if #sessions >= limit then break end
          end
        end

        return sessions
      end

      local function sessions_footer()
        displayed_sessions = get_recent_sessions(8)
        local lines = { '', '󱂬 Sessions' }

        for index, session in ipairs(displayed_sessions) do
          lines[#lines + 1] = string.format('   [%d] %s', index, session.name)
        end

        if #displayed_sessions == 0 then lines[#lines + 1] = '   No saved sessions' end

        return lines
      end

      local function open_session_under_cursor()
        local line = vim.trim(vim.api.nvim_get_current_line())
        local index = tonumber(line:match '^%[(%d+)%]')
        local session = index and displayed_sessions[index]

        if not session then return false end

        pcall(vim.cmd, 'Neotree close')
        MiniSessions.read(session.name)
        return true
      end

      require('dashboard').setup {
        theme = 'hyper',
        config = {
          project = {
            enable = true,
            limit = 8,
            icon = '󰉋 ',
            label = 'Projects',
            action = 'Telescope find_files cwd=',
          },
          mru = {
            enable = true,
            limit = 10,
            icon = '󰈙 ',
            label = 'Recent Files',
            cwd_only = false,
          },
          footer = sessions_footer(),
        },
      }

      vim.api.nvim_create_autocmd('User', {
        pattern = 'DashboardLoaded',
        callback = function(args)
          local default_enter = vim.fn.maparg('<CR>', 'n', false, true)
          local default_enter_callback = type(default_enter) == 'table' and default_enter.callback or nil

          vim.keymap.set('n', '<CR>', function()
            if open_session_under_cursor() then return end
            if default_enter_callback then default_enter_callback() end
          end, { buffer = args.buf, silent = true, nowait = true })

          vim.keymap.set('n', '<LeftMouse>', function()
            vim.cmd.normal { args = { '<LeftMouse>' }, bang = true }
            open_session_under_cursor()
          end, { buffer = args.buf, silent = true, nowait = true })
        end,
      })
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
