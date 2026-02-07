-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'tpope/vim-fugitive',
    keys = {
      { '<leader>gg', '<cmd>Git<cr>', desc = 'Fugitive: Git' },
      { '<leader>gp', '<cmd>Git push<cr>', desc = 'fugitive: git push' },
      { '<leader>gP', '<cmd>Git pull<cr>', desc = 'fugitive: git pull' },
    },
  }, -- Add support for Git management

  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      direction = 'float',
    },
  },

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
        http = {
          openai_responses = function()
            return require('codecompanion.adapters').extend('openai_responses', {
              schema = {
                top_p = {
                  ---@type fun(self: CodeCompanion.HTTPAdapter): boolean | boolean
                  enabled = function(self)
                    local model = self.schema.model.default
                    if model:find 'codex%' then return false end
                    return true
                  end,
                },
              },
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
