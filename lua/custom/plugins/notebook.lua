-- This is used to enable jupyter notebook editing in NVIM
return {
  {
    'geg2102/nvim-jupyter-client',
    event = { 'BufReadPre *.ipynb', 'BufNewFile *.ipynb' },
    config = function()
      require('nvim-jupyter-client').setup {
        -- keep defaults; only tweak if you want different highlight/template
      }

      local opts = { buffer = true, silent = true }
      vim.keymap.set('n', '<leader>ja', '<cmd>JupyterAddCellBelow<CR>', vim.tbl_extend('force', opts, { desc = 'Jupyter: add cell below' }))
      vim.keymap.set('n', '<leader>jA', '<cmd>JupyterAddCellAbove<CR>', vim.tbl_extend('force', opts, { desc = 'Jupyter: add cell above' }))
      vim.keymap.set('n', '<leader>jd', '<cmd>JupyterRemoveCell<CR>', vim.tbl_extend('force', opts, { desc = 'Jupyter: remove cell' }))
      vim.keymap.set('n', '<leader>jm', '<cmd>JupyterMergeCellAbove<CR>', vim.tbl_extend('force', opts, { desc = 'Jupyter: merge above' }))
      vim.keymap.set('n', '<leader>jM', '<cmd>JupyterMergeCellBelow<CR>', vim.tbl_extend('force', opts, { desc = 'Jupyter: merge below' }))
      vim.keymap.set('n', '<leader>jt', '<cmd>JupyterConvertCellType<CR>', vim.tbl_extend('force', opts, { desc = 'Jupyter: toggle code/markdown' }))
      vim.keymap.set('v', '<leader>jv', '<cmd>JupyterMergeVisual<CR>', vim.tbl_extend('force', opts, { desc = 'Jupyter: merge selected cells' }))
      vim.keymap.set('n', '<leader>jx', '<cmd>JupyterDeleteCell<CR>', vim.tbl_extend('force', opts, { desc = 'Jupyter: delete cell -> register' }))
    end,
  },

  {
    'geg2102/nvim-python-repl',
    ft = { 'python', 'ipynb' }, -- you can include "lua","scala" too if you use them
    config = function()
      require('nvim-python-repl').setup {
        execute_on_send = true,
        vsplit = true, -- vertical split REPL
        -- prompt_spawn = false,
        spawn_command = { python = 'ipython' }, -- default is ipython anyway
      }

      -- Core REPL controls
      vim.keymap.set('n', '<leader>ro', function() require('nvim-python-repl').open_repl() end, { desc = 'REPL: open' })
      vim.keymap.set({ 'n', 'v', 'i', 't' }, '<leader>rr', function() require('nvim-python-repl').toggle_repl_win() end, { desc = 'REPL: toggle window' })

      -- Sending code
      vim.keymap.set('n', '<leader>rs', function() require('nvim-python-repl').send_statement_definition() end, { desc = 'REPL: send semantic unit' })
      vim.keymap.set('v', '<leader>rv', function() require('nvim-python-repl').send_visual_to_repl() end, { desc = 'REPL: send visual selection' })
      vim.keymap.set('n', '<leader>rb', function() require('nvim-python-repl').send_buffer_to_repl() end, { desc = 'REPL: send buffer' })

      -- Notebook integration (the “bonus” function in the README)
      vim.keymap.set('n', '<leader>rc', function() require('nvim-python-repl').send_current_cell_to_repl() end, { desc = 'REPL: send current notebook cell' })

      -- Convenience toggles
      vim.keymap.set('n', '<leader>re', function() require('nvim-python-repl').toggle_execute() end, { desc = 'REPL: toggle execute_on_send' })
      vim.keymap.set('n', '<leader>rV', function() require('nvim-python-repl').toggle_vertical() end, { desc = 'REPL: toggle vertical split' })
    end,
  },
}
