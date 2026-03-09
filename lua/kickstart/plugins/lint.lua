-- NOTE: Helps NVim's language server client use standalone linters to provide diagnostic
-- messages, particularly when they'd do a better job than the LSP

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = { -- Actually has defaults BUT better to do the following
      markdown = { 'markdownlint' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      svelte = { 'eslint_d' },
      -- Add `vale` for markdown and txt?
    } -- AND NOT the following which enables 10 linters from clojure to text files
    -- lint.linters_by_ft = lint.linters_by_ft or {}
    -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
    -- Requiring you to disable any you don't want (See nvim-lint/blob/master/lua/lint)
    -- lint.linters_by_ft['clojure'] = nil

    -- Actually enables the linting based on these events
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only lint IF the file is editable, i.e. ignore documentation files or tooltips
        if vim.bo.modifiable then lint.try_lint() end
      end,
    })
  end,
}
