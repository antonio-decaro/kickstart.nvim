-- This is used to enable jupyter notebook editing in NVIM
return {
  {
    'jeryldev/pyworks.nvim',
    dependencies = {
      'benlubas/molten-nvim',
      '3rd/image.nvim',
    },
    config = function()
      require('pyworks').setup {
        -- Image rendering
      } -- See Configuration section for options
    end,
    lazy = false,
    priority = 100,
  },
}
