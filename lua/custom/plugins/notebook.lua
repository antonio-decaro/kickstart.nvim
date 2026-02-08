-- This is used to enable jupyter notebook editing in NVIM
return {
  {
    'geg2102/nvim-jupyter-client',
    config = function() require('nvim-jupyter-client').setup {} end,
  },
}
