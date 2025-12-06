-- NOTE: Helps NVim's language server client use standalone linters to provide diagnostic
-- messages, particularly when they'd do a better job than the LSP

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = {
      markdown = { 'markdownlint' },
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
    }

    -- It's possible to let other plugins add linters via below:
    -- lint.linters_by_ft = lint.linters_by_ft or {}
    -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
    -- BUT it enables the following linters automatically: clojure
    -- dockerfile, inko, janet, json, markdown, rst, ruby, terraform, and text
    -- To disable the defaults (and stop their errors), set their filetype to nil
    -- lint.linters_by_ft['dockerfile'] = nil
    -- lint.linters_by_ft['json'] = nil
    -- lint.linters_by_ft['markdown'] = nil
    -- lint.linters_by_ft['ruby'] = nil

    -- Create autocommand which carries out the actual linting
    -- on the specified events.
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only run the linter in buffers that you can modify in order to
        -- avoid superfluous noise, notably within the handy LSP pop-ups that
        -- describe the hovered symbol using Markdown.
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end,
    })
  end,
}
