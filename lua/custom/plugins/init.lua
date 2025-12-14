-- Add any # of simple plugin specs to load here or add them in their own file in the dir!
return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim',
    },
    config = function()
      require('render-markdown').setup {
        heading = {
          icons = { '⓵  ', '⓶  ', '⓷  ', '⓸  ', '⓹  ', '⓺  ' },
        },
        bullet = {
          ordered_icons = function(ctx)
            local value = vim.trim(ctx.value) -- Value == num + '.' i.e. '1.' or '2.' etc
            local value_index = tonumber(value:sub(1, #value - 1)) --  Grabs number alone
            -- Return MY number, not the auto-index aka index (which always starts from 1)
            return string.format('%d.', value_index)
          end,
        },
      }
    end,
  },
}
