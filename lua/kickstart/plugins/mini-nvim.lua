-- NOTE: Provides a collection of various small independent plugins/modules/extensions

return {
  {
    'echasnovski/mini.nvim',
    config = function()
      -- NOTE: Adds new verbs to `Around`/`Inside` motions + new motions like "q" = quotes
      -- Examples:
      --   va)  - [V]isually select [A]round [)]paren
      --   yinq - [Y]ank [I]nside [N]ext [']quote
      --   ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- NOTE: Adds "s" verb, [s]urrounding text with brackets, quotes, etc
      -- Examples:
      --   saiw) - [S]urround [A]DD [I]nner [W]ord [)]Parentheses
      --   sd'   - [S]urround [D]ELETE [']quotes
      --   sr)'  - [S]urround [R]EPLACE [)]Parentheses [']Quotes
      require('mini.surround').setup()

      -- NOTE: Add simple status line (though there's plenty of other status line plugins)
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() -- Override status line formatter entirely
        return 'Line=%2l:Col=%2v'
      end
    end,
  },
}
