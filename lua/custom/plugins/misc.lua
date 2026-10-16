-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
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
      vim.keymap.set('t', '<C-h>', function() vim.cmd 'wincmd h' end, { desc = 'Move left from terminal' })
      vim.keymap.set('t', '<C-j>', function() vim.cmd 'wincmd j' end, { desc = 'Move down from terminal' })
      vim.keymap.set('t', '<C-k>', function() vim.cmd 'wincmd k' end, { desc = 'Move up from terminal' })
      vim.keymap.set('t', '<C-l>', function() vim.cmd 'wincmd l' end, { desc = 'Move right from terminal' })
      vim.keymap.set('n', '<A-h>', ss.resize_left, { desc = 'Resize left (nvim/wezterm)' })
      vim.keymap.set('n', '<A-j>', ss.resize_down, { desc = 'Resize down (nvim/wezterm)' })
      vim.keymap.set('n', '<A-k>', ss.resize_up, { desc = 'Resize up (nvim/wezterm)' })
      vim.keymap.set('n', '<A-l>', ss.resize_right, { desc = 'Resize right (nvim/wezterm)' })
    end,
  },
  {
    'the-mayankjha/fk_markdown.nvim',
    config = function() require('fk_markdown').setup {} end,
  },
  {
    'frabjous/knap',
    ft = { 'tex', 'markdown' },
    config = function()
      vim.g.knap_settings = {
        -- LaTeX: compile with the TeX distribution installed on this Mac and
        -- open the generated PDF in the default macOS PDF application.
        texoutputext = 'pdf',
        textopdf = 'pdflatex -synctex=1 -halt-on-error -interaction=nonstopmode %docroot%',
        textopdfviewerlaunch = 'open %outputfile%',
        textopdfviewerrefresh = 'none',
        -- Knap defaults to rubber-info, which is not installed on this Mac.
        -- Read the first TeX error directly from the compilation log instead.
        textopdfshorterror = 'A=%outputfile% ; LOGFILE="${A%.pdf}.log" ; grep -m 1 "^!" "$LOGFILE" || tail -n 1 "$LOGFILE"',

        -- Markdown: render a standalone HTML document with Pandoc, then open
        -- it with the application registered for HTML files.
        mdoutputext = 'html',
        mdtohtml = 'pandoc --standalone %docroot% -o %outputfile%',
        mdtohtmlviewerlaunch = 'open %outputfile%',
        mdtohtmlviewerrefresh = 'none',
      }

      local kmap = vim.keymap.set
      kmap({ 'n', 'v', 'i' }, '<F5>', function() require('knap').process_once() end)
      kmap({ 'n', 'v', 'i' }, '<F6>', function() require('knap').close_viewer() end)
      kmap({ 'n', 'v', 'i' }, '<F7>', function() require('knap').toggle_autopreviewing() end)
      kmap({ 'n', 'v', 'i' }, '<F8>', function() require('knap').forward_jump() end)
    end,
  },
}
