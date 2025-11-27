-- NOTE: Provides a collection of various small independent plugins/modules/extensions

return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      -- NOTE: Adds new verbs to `Around`/`Inside` motions + new motions like "q" = quotes
      -- Examples:
      --   va)  - [V]isually select [A]round [)]paren
      --   yinq - [Y]ank [I]nside [N]ext [']quote
      --   ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- NOTE: Acts as an alternate and simpler windowed file explorer instead of NetRW
      require('mini.files').setup {
        content = {
          filter = function(fs_entry) -- Ignore list to de-clutter the explorer
            local ignore_list = { '%.DS_Store', '^%.git$', '%.vscode', '%.ruby-lsp' }
            for _, ignored_file in ipairs(ignore_list) do
              if string.find(fs_entry.name, ignored_file, 1, false) then
                return false
              end
            end
            return true
          end,
        },
      }

      -- NOTE: Adds highlights to words similar to `todo-comments`
      local hipatterns = require 'mini.hipatterns'
      hipatterns.setup {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          -- fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          commentWarn = { pattern = '--!', group = 'MiniHipatternsHack' },

          hex_color = hipatterns.gen_highlighter.hex_color(), -- Colors all hex strings
        },
      }

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
