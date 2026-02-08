return {
  {
    'olimorris/codecompanion.nvim',
    version = '^18.0.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- optional, but recommended for Actions picker
    },
    cmd = {
      'CodeCompanion',
      'CodeCompanionChat',
      'CodeCompanionActions',
      'CodeCompanionCmd',
    },
    keys = {
      { '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'CodeCompanion Chat (toggle)' }, -- doc command  [oai_citation:0‡GitHub](https://raw.githubusercontent.com/olimorris/codecompanion.nvim/refs/heads/main/doc/codecompanion.txt?utm_source=chatgpt.com)
      { '<leader>ca', '<cmd>CodeCompanionActions<cr>', desc = 'CodeCompanion Actions' },
      { '<leader>ci', '<cmd>CodeCompanion<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion Inline' },
    },
    opts = {
      adapters = {
        acp = {
          codex = function()
            return require('codecompanion.adapters').extend('codex', {
              defaults = {
                auth_method = 'chatgpt', -- "openai-api-key"|"codex-api-key"|"chatgpt"
              },
              -- strongly recommended: do NOT hardcode; use env var instead
              -- env = { OPENAI_API_KEY = 'my-api-key' },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = 'codex',
        },
        inline = {
          adapter = 'openai_responses',
        },
      },
      display = {
        diff = { enabled = true },
      },
    },
  },
}
