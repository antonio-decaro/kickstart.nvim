return {
  { -- CMake Tools
    'Civitasv/cmake-tools.nvim',
    name = 'cmake-tools.nvim',
    init = function()
      local function has_cmake_lists(cwd)
        return cwd and vim.fn.filereadable(cwd .. '/CMakeLists.txt') == 1
      end

      local function load_if_cmake_project()
        if has_cmake_lists(vim.uv.cwd()) then
          require('lazy').load { plugins = { 'cmake-tools.nvim' } }
        end
      end

      local group = vim.api.nvim_create_augroup('CMakeToolsAutoLoad', { clear = true })
      vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
        group = group,
        callback = load_if_cmake_project,
      })
    end,
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
