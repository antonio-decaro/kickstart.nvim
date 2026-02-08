return {
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gg', '<cmd>Git<cr>', desc = 'Fugitive: Git' },
      { '<leader>gp', '<cmd>Git push<cr>', desc = 'fugitive: git push' },
      { '<leader>gP', '<cmd>Git pull<cr>', desc = 'fugitive: git pull' },
    },
  }, -- Add support for Git management
}
