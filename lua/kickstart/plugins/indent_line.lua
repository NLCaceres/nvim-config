-- NOTE: Adds vertical indentation lines for easier reading, even on blank lines
---@module 'lazy'
---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  main = 'ibl', -- See `:help ibl` for a help guide
  ---@module 'ibl'
  ---@type ibl.config
  opts = {},
}
