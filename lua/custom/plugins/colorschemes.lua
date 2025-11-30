-- NOTE: Fun and cool colorschemes - Just run `vim.cmd.colorscheme <string-name>`
return {
  -- Other interesting colors to consider - Oldworld/Mellow, OneDark
  -- Best to good built colors - retrobox, wildcharm, slate, koehler, sorbet, zaibetsu
  {
    dir = '~/.config/nvim/lua/my_plugins/vangelion',
    name = 'vangelion',
    lazy = false,
    priority = 1000,
  },
  {
    'ray-x/aurora',
    priority = 1000, -- Set to 1000, so it loads before any other plugin
    config = function()
      -- vim.cmd.colorscheme 'aurora' -- Activate color (or its variant) as default for files
    end,
    init = function()
      vim.api.nvim_set_hl(0, '@number', { fg = '#e933e3' }) -- Globally update the scheme
      vim.cmd.hi 'Comment gui=none' -- How to make changes to the colorscheme
    end,
  },
  { -- Configurable via on_colors()
    'eldritch-theme/eldritch.nvim',
    priority = 999,
    init = function()
      -- vim.cmd.colorscheme 'eldritch'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
  { -- Configurable via on_colors()
    'miikanissi/modus-themes.nvim',
    priority = 999,
    init = function()
      -- vim.cmd.colorscheme 'modus'
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
}
