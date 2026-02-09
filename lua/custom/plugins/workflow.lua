return {
  { -- CMake Tools
    'Civitasv/cmake-tools.nvim',
    opts = {},
    keys = {
      { '<leader>mb', '<cmd>CMakeBuild -j<cr>', mode = { 'n' }, desc = 'C[M]ake [B]uild' },
      { '<leader>md', '<cmd>CMakeSelectBuildDir <cr>', mode = { 'n' }, desc = 'C[M]ake Select Build [D]ir' },
      { '<leader>mt', '<cmd>CMakeSelectBuildTarget <cr>', mode = { 'n' }, desc = 'C[M]ake Select Build [T]arget' },
      { '<leader>mD', '<cmd>CMakeSelectCwd <cr>', mode = { 'n' }, desc = 'C[M]ake Select current working [D]irectory' },
      { '<leader>mc', '<cmd>CMakeOpenCache <cr>', mode = { 'n' }, desc = 'C[M]ake Open [C]ache' },
    },
  },
}
