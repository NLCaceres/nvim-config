-- NOTE: Highlights todos, fixes, notes, warnings etc! Super helpful of course!

return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false, -- Shows sign in the left column
      keywords = { -- Should merge correctly BUT special chars AREN'T VALID!
        -- ["'!'"] = { color = 'warning' },
        -- ["'?'"] = { color = 'warning' },
        -- ['-:'] = { color = 'warning' },
      },
    },
  },
}
