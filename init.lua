--[[

=====================================================================
========== NOTE: READ THIS 1000 LINE DOC BEFORE CONTINUING ==========
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

WARN: READ ME! Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- NOTE: Neovim uses `vim.g` to config global editor settings
-- Ex: Set <space> as the leader key. Check `:help mapleader` for more info
-- WARN: Leader must be changed here, b4 plugins are loaded, or else keymaps are wrong later
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true -- Set to true if NerdFont installed & used in your terminal
vim.g.netrw_list_hide = '.DS_Store,.git/$,.vscode,.ruby-lsp' -- Setup NetRW ignore list

-- NOTE: Neovim uses `vim.o` to config buffer & window settings. See `:help vim.o`
-- Change these options however you want! Also see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- Can also make line numbers relative, helping with jumps! Try it out!
-- vim.o.relativenumber = true

vim.o.mouse = 'a' -- Enables mouse mode, useful to resize split buffers

vim.o.showmode = false -- Hides mode since status line already shows it

-- Syncs clipboard between your OS and Neovim. See `:help 'clipboard'`
-- Remove it to keep your OS clipboard independent/untouched
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true -- Wrapped lines keep the same indent level

vim.o.undofile = true -- Keep a long undo history

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes' -- Allows signs (like for Git) in the num column

vim.o.updatetime = 250 -- Decrease update time

vim.o.timeoutlen = 300 -- Decrease keymap sequence wait time, showing `which-key` popup quicker

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Neovim displays whitespace using these chars. See `:help 'list'` `:help 'listchars'`
vim.o.list = true
vim.o.listchars = 'tab:» ,trail:·,nbsp:␣'

-- Adds confirmation check if operation would leave unsaved changes in buffer (like `:q`)
vim.o.confirm = true

vim.o.inccommand = 'split' -- Preview substitutions live while typing

vim.o.cursorline = true

vim.o.scrolloff = 10 -- Min num of lines on screen above & below your cursor

-- NOTE: Keymaps - See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.o.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Return to Normal mode from Insert Mode
vim.keymap.set('i', 'kj', '<Esc>')

-- Toggle Vim Spellchecker - See its useful keybindings starting `[` `]` and `z`
vim.keymap.set('n', '<leader>tc', function()
  vim.o.spell = not vim.o.spell
end, { desc = 'Toggle Spell [C]hecker' })

-- Toggle between line number and relative line numbers
vim.keymap.set('n', '<leader>tl', function()
  if vim.o.number == true then
    vim.o.number = false
    vim.o.relativenumber = true
  else
    vim.o.number = true
    vim.o.relativenumber = false
  end
end, { desc = 'Toggle [L]ine Numbers' })

-- Save and quitting
vim.keymap.set('n', '<leader>ts', vim.cmd.write, { desc = '[S]ave' })
vim.keymap.set('n', '<leader>tq', vim.cmd.quit, { desc = '[Q]uit' })
vim.keymap.set('n', '<leader>tf', function()
  vim.cmd.write()
  vim.cmd.quit()
end, { desc = 'Save, Quit, and [F]inish' })
-- WARN: `:Ex` != `:ex` - Uppercase = NetRW File explorer vs the vim `:edit` command
vim.keymap.set('n', '<leader>on', function()
  require('mini.files').open()
end, { desc = 'Go to [N]etRW Directory Listing' })
vim.keymap.set('n', '<leader>tn', function()
  vim.cmd.write()
  require('mini.files').open()
end, { desc = 'Save and open [N]etRW' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Sets up an easier way to exit Vim's terminal mode, instead of `<C-\>` `<C-n>`
-- BUT it won't work in all terminals/tmux/etc, so may need to try another map
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- NOTE: Autocommands - See `:help lua-guide-autocommands`

-- Highlight on yank (copying) text - See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- Setup how tabs look, usually 2 whitespaces, BUT another method is a `ftplugin` folder
-- Ex: `nvim/ftplugin/go.lua`, adding the `bo` option. See `:h ftplugin`
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Apply consistent and space-efficient tab spacing',
  callback = function(args)
    local tabSpaceTable = {
      [2] = { 'go', 'templ', 'lua', 'java', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'html', 'css', 'yaml' },
      [4] = { 'python' },
    }
    for i, v in pairs(tabSpaceTable) do
      for _, lang in ipairs(v) do
        if args.match == lang then
          vim.bo.tabstop = i
          vim.bo.softtabstop = i
          vim.bo.shiftwidth = i
          vim.bo.expandtab = true
          return
        else -- Reset to their defaults
          vim.bo.tabstop = 8
          vim.bo.softtabstop = 0
          vim.bo.shiftwidth = 8
          vim.bo.expandtab = false
        end
      end
    end
  end,
})

-- NOTE: Install `lazy.nvim` plugin manager - See `:help lazy.nvim.txt` or `github.com/folke/lazy.nvim`
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath) -- Using a colon to call a func, inserts self a la `python` methods

-- NOTE: Configure and install plugins
--  Check plugin status via `:Lazy`
--  You can press `?` in this menu for help. Use `:q` to close the window
--  Update plugins via :Lazy update
-- INSTALL PLUGINS IN THIS SETUP FUNC
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added via table, {}, listing the name first,
  -- and then other config options to change behavior, loading, etc

  -- NOTE: This is a more advanced example, passing config too `which-key.nvim`
  -- To do it outside of Lazy's setup , you'd run `require('which-key').setup({...})`
  -- When plugins load, we can run Lua, helping group config AND even lazy-load plugins
  -- Ex: `event = 'VimEnter'` loads `which-key` BEFORE Neovim's UI loads - See `:help autocmd-events`
  { -- Any actual config func in the plugin spec runs AFTER `VimEnter`
    'folke/which-key.nvim', -- Shows useful keybindings with descriptions
    event = 'VimEnter', -- Load this plugin when `VimEnter` event happens
    opts = {
      delay = 0, -- Millisecond delay opening popup, independent of `vim.o.timeoutlen`
      icons = {
        mappings = vim.g.have_nerd_font, -- With NerdFonts `keys` here can be empty table
        keys = vim.g.have_nerd_font and {} or { -- Otherwise we need these defaults
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      spec = { -- Documents the keymaps
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can list dependencies in spec tables AND it'll grab them for us
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = 'master',
    dependencies = { -- List this plugin's dependencies
      'nvim-lua/plenary.nvim',
      { -- See `telescope-fzf-native` README for installation instructions if errors
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make', -- `build` runs a command on plugin install/update
        cond = function() -- Determines IF this plugin should be installed/loaded
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' }, -- Use Telescope for Vim's UI Select
      { 'debugloop/telescope-undo.nvim' }, -- Undo tree
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that can find a lot of different things!
      -- To use it directly, run `:Telescope <tab>`
      -- NOTE: For helpful keymaps when using Telescope: Press ? or <c-/> in insert mode
      require('telescope').setup { -- For more info see `:help telescope.setup()`
        defaults = { -- Can update the defaults like keymaps in here
          -- In lua patterns "%" escapes magic chars -- ALSO generic 'lock.yaml$' needed?
          file_ignore_patterns = { '^%.git/', 'pnpm%-lock%.yaml' },
          layout_config = {
            horizontal = { mirror = true, width = 0.9, preview_width = 0.5 },
          },
        },
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
          undo = {},
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'undo')

      -- NOTE: Convenient & Common places for Telescope to search
      local builtin = require 'telescope.builtin' -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sn', function() -- Lists Neovim config files
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
      vim.keymap.set('n', '<leader>scs', builtin.colorscheme, { desc = '[S]earch [C]olor[S]cheme' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>su', '<cmd>Telescope undo<cr>') -- Visual undo-tree
      vim.keymap.set('n', '<leader>sf', function()
        -- find_files runs `rg --file --color never` if installed OR `find . -type f`
        -- There are built-in alternatives BUT best to change `find_file` as shown below,
        -- OR via `find_command` key, e.g. { "rg", "--file", "--color", "never", "--sort", "--smart-case" }
        builtin.find_files { hidden = true }
      end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sgi', function()
        builtin.git_status { git_icons = { added = '󱇬', changed = '!=' } }
      end, { desc = '[S]earch by [GI]t' })
      vim.keymap.set('n', '<leader>sgr', function()
        builtin.live_grep { additional_args = { '--hidden', '--sortr=path' } }
      end, { desc = '[S]earch by [GR]ep' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function() -- Similar to normal "/" keymap
        -- Like `find_files` can add extra config to totally change Telescope presentation
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep { -- See `:help telescope.builtin.live_grep` for its config
          grep_open_files = true, -- Ex: `live_grep` specific config option
          prompt_title = 'Live Grep in Open Files', -- OR can even change default configs
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'TelescopePreviewerLoaded',
        callback = function(args) -- Missing helpful `args.data`
          vim.bo.tabstop = 2
          vim.bo.softtabstop = 2
          vim.bo.shiftwidth = 2
          vim.expandtab = true
        end,
      })
    end,
  },

  -- NOTE: LSP Plugins
  { -- `lazydev` configs Lua LSP to analyze the Neovim config dir & resolve the NVim APIs
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  { -- NOTE: The true heart and soul plugin of LSP Configuration in Neovim
    'neovim/nvim-lspconfig', -- Auto installs LSPs + linters, formetters, etc to stdpath
    dependencies = { -- BUT it NEEDS `Mason`, NVim's LSP installation manager
      -- To check installed LSPs, etc, run `:Mason`, and press `g?` for help inside
      -- NOTE: `opts = {}` ensures `require('mason').setup({})` is called
      { 'mason-org/mason.nvim', version = '^1.0.0', opts = {} },
      { 'mason-org/mason-lspconfig.nvim', version = '^1.0.0' },
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      { 'j-hui/fidget.nvim', opts = {} }, -- Provides LSP status updates

      'saghen/blink.cmp', -- Ensure we have auto-complete from `blink.cmp`
    },
    config = function()
      -- NOTE: BUT **WHAT IS A LSP?!** - A Language Server Protocol to help editors "read"
      -- programming languages. The "server" is a local process that provides definitions,
      -- references, autocompletions, symbols, and way more to clients/editors
      -- What about LSP vs TreeSitter? Check `:help lsp-vs-treesitter`
      --
      vim.api.nvim_create_autocmd('LspAttach', { -- Run IF a LSP attaches to the filetype
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: LUA IS A PROGRAMMING LANGUAGE - It can easily define small helper funcs
          -- to prevent repeating oneself, e.g. the following keymapper for the LSPs
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Fuzzy find ALL current document symbols, i.e. vars, funcs, types, etc
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find ALL of your workspace symbols, i.e. recursively check ALL files
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to where the highlighted word was first defined - Jump back via `<C-t>`
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- GO TO DECLARATION, NOT DEFINITION, i.e. a C-header file
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Jump to highlighted word's type definition, NOT where the word was defined
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Jump to implementation of highlighted word, i.e. not the type interface
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          -- Find references for highlighted word
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Rename highlighted variable, even across files
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Run a code action on highlighted error or suggestion
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- This func fixes a diff between Neovim Nightly v0.11 and stable v0.10
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some LSP support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          -- Enables inlay hints directly inline w/ code IF the LSP supports it (uncommon)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end

          -- These autocommands highlight and then un-highlight references to the word
          -- under your cursor if you pause for a bit. See `:help CursorHold` for info
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })
      vim.diagnostic.config { -- See :help vim.diagnostic.Opts
        severity_sort = true,
        float = { border = 'single', source = 'if_many' },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- `K` now by default opens [K]eywordprg's tooltip - Moving away to disappear
      -- Also see `:help K` - The following should help style it's popup
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

      -- By default, NVim CAN'T handle everything the LSP supports SO blink.cmp, luasnip,
      -- etc help fill in capabilities and can be added to individual LSP config tables
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Add/Remove LSPs here to install, enable and config them, usually by these opts:
      --   cmd (table): Override start command
      --   filetypes (table): Override filetypes LSP should attach
      --   capabilities (table): Override NVim default capabilities OR disable LSP feats
      --   settings (table): Override LSP defaults on startup
      --     Check https://luals.github.io/wiki/settings for `lua_ls` example
      --     OR https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
      local servers = { -- OR search `:help lspconfig-all` for list of LSP pre-set configs
        gopls = { -- For Go, it shows `cmd = { "gopls" }`, `filetypes = { "go"... }`, etc
          settings = { -- Oddly (but not uncommonly) a `gopls` key is nested `settings`
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedParams = true,
              },
            },
          },
        },
        templ = {},

        lua_ls = { -- For Lua, it has `cmd`, `filetypes` & `root_markers = {".luarc.json"}`
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },

        -- Some LSPs even iterate on others - `pyright` to `basedpyright`
        basedpyright = { -- Though there is `pylsp` as a total alternative
          settings = {
            basedpyright = {
              --typeCheckingMode = 'standard', -- 'recommended' default BUT lots of errs
              disableOrganizeImports = true,
              analysis = {
                inlayHints = {
                  variableTypes = true,
                  callArgumentNames = false,
                  functionReturnTypes = true,
                },
                -- Probably put `reportX` type config overriden rules here
              },
              -- analysis = {
              --   ignore = { '*' },
              -- },
            }, -- Can set specific 'venv' folder BUT best done via local pyproject.toml
          }, -- Though defaults to '.venv' folder in root IF activated in the terminal
        },
        ruff = { settings = {} },

        ruby_lsp = {},

        -- Some languages like TS get FULL-ON plugins (Pmizio's Typescript-Tools)
        ts_ls = { -- BUT getting the LSP from Mason is usually enough
          -- init_options = {}
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'html',
            'typescript',
            'typescriptreact',
            'typescript.jsx',
          },
        }, -- `eslint-lsp` & `ts_ls` are extra unique by being VSCode's extracted LSPs
        cssls = {},
        html = { -- Provides formatter too AND works with `templ`
          -- settings = {
          --   html = { format = { preserveNewLines = true } },
          -- },
        },
        emmet_language_server = {
          filetypes = {
            'css',
            'eruby',
            'html',
            'htmlangular',
            'htmldjango',
            'javascript',
            'javascriptreact',
            'less',
            'sass',
            'scss',
            'pug',
            'typescriptreact',
            'templ',
            'vue',
          },
          -- Opts from https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration
          -- OR https://docs.emmet.io - specifically in /customization/preferences
          -- AND /customization/syntax-profiles/ AND /customization/snippets/#variables
          init_options = { -- No other options are supported
            includeLanguages = {}, ---@type table<string, string>
            excludeLanguages = {}, --- @type string[]
            extensionsPath = {}, --- @type string[]
            preferences = {}, --- @type table<string, any>
            showAbbreviationSuggestions = true, --- @type boolean Defaults to `true`
            showExpandedAbbreviation = 'always', --- @type "always" | "never"
            showSuggestionsAsSnippets = false, --- @type boolean
            syntaxProfiles = {}, --- @type table<string, any>
            variables = {}, --- @type table<string, string>
          },
        },

        yamlls = {
          settings = { yaml = {
            customTags = { '!merge sequence', '!override sequence', '!reset sequence' },
          } },
        },
      }

      -- Add in Mason's other available tools to NVim -- linters, formatters & debuggers
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, { -- Add this list/table to `ensure_installed`
        'stylua', -- Used to format Lua code
        'prettierd', -- Daemon version of fast but opinionated Prettier
        'eslint_d', -- Fastest way to use `ESLint` (over `eslint-lsp`)
        'rubocop',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- NOTE: LSPs added to `server` table list get auto-installed here
      require('mason-lspconfig').setup {
        ensure_installed = {}, -- Empty so `mason-tool-installer` can fill it
        automatic_installation = false,
        handlers = { -- Each lang can get its own, e.g. `ts_ls = funct`
          function(server_name) -- OR can use a default func that runs for all languages
            local server = servers[server_name] or {}
            -- Can overwrite or even disable LSP capability config by merging my options
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
  {
    'nvim-java/nvim-java',
    config = function()
      require('java').setup {
        jdk = {
          auto_install = false,
        },
      }
      vim.lsp.config('jdtls', {
        settings = {
          java = {
            configuration = {
              runtimes = {
                { -- MUST set `export JAVA_HOME=<jbr-path>` in `.zshrc` to help JDTLS
                  name = 'Jetbrains-Runtime-21',
                  path = '/Applications/Android Studio.app/Contents/jbr/Contents/Home',
                  default = true,
                },
                {
                  name = 'Jetbrains-Virtual-Machine-17',
                  path = vim.env.HOME .. '/Library/Java/JavaVirtualMachines/jbrsdk-17.0.9-3/Contents/Home',
                },
              },
            },
            format = {
              settings = {
                url = vim.fn.stdpath 'config' .. '/lua/custom/formatters/java.xml',
              },
            },
          },
        },
      })
      vim.lsp.enable 'jdtls'
    end,
  },

  { -- NOTE: Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      formatters_by_ft = { -- By Filetype
        go = { 'gofmt' }, -- `gopls` includes `gofmt` BUT `gofumpt` is stricter alt option
        templ = { 'gofmt' },
        lua = { 'stylua' },
        -- There's also `ruff_format` BUT it usually overrides its linter for some reason
        python = { 'ruff_fix', 'ruff_organize_imports' }, -- Runs sequentially
        -- Can use a sub-list to try each until one is found OR `stop_after_first` opt
        javascript = { 'prettierd' }, -- {{ 'prettierd', 'eslint_d' }}
        javascriptreact = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        ruby = { 'rubocop' },
      },
      format_on_save = function(bufnr) -- Conform CAN fallback to a LSP formatter if needed
        -- Add langs to ensure ALWAYS formatted by formatter and NEVER by the LSP
        local disable_filetypes = { c = true, cpp = true, python = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
    },
  },

  { -- NOTE: Autocompletion suggestions
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      { -- Neovim's snippet engine written in Lua
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- NEED build step to support regex in snippets BUT often won't work in Windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- { -- Contains variety of helpful snippets for many languages
          --   'rafamadriz/friendly-snippets',
          --   config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = { -- A few different 'preset' keymaps BUT 'default' is recommended
        -- It sets accept to `<c-y>` rather than <tab> or <enter> or 'none' for no map
        -- Why `<c-y>`? See `:help ins-completion`
        -- BUT all presets use `<tab>` to move in snippet, `<c-space>` to open menu or
        -- docs, `<c-n>/<c-p>` to select next/prev suggestion, <c-e> to hide and <c-k>
        -- to toggle signature help. See also `:h blink-cmp-config-keymap`
        preset = 'default', -- OR github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-r>'] = { 'snippet_backward', 'fallback' },
      },
      appearance = {
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono', -- Default + recommended UNLESS not using NerdFontMono
      },
      completion = {
        -- `auto_show = true` to show docs after 500ms delay WITHOUT using `<c-space>`
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
      snippets = { preset = 'luasnip' },

      -- `blink.cmp` has an optional BUT recommended fuzzy matcher built in Rust
      -- Currently using Lua version BUT can install other via `prefer_rust_with_warning`
      fuzzy = { implementation = 'lua' }, -- See `:h blink-cmp-config-fuzzy` for info

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  -- NOTE: Treesitter analyzes shape of code to help navigate, edit & highlight code by
  -- analyzing the shape, identifying basic, common building blocks like func declarations,
  -- var types, etc while a LSP would specifically analyze a language's semantics/syntax
  -- Treesitter, therefore, is instrumental for linters, plugins like `mini.ai` to make
  { -- `yinq` as a motion, or colorschemes to highlight a particular code block pattern
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'go',
        'java',
        'html',
        'javascript',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'typescript',
        'vim',
        'vimdoc',
      },
      auto_install = true, -- Auto-install languages
      highlight = {
        enable = true,
        -- Some langs have indent issues because they need Vim's Regex highlighting system
        additional_vim_regex_highlighting = { 'ruby' }, -- like Ruby!
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- Treesitter has more modules that leverage its tree to add cool features, namely
  },

  -- NOTE: Can also add more plugins by `require`-ing its spec. Uncomment and check it out!
  require 'kickstart.plugins.debug', -- All of these are good recommendations!
  require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  require 'kickstart.plugins.mini-nvim',
  require 'kickstart.plugins.todo-comments',

  -- NOTE: OR add plugins via `{ import = 'some.dir.file' }` or `{ import = 'some.dir' }`
  -- which grabs all lua files in the directory AND loads all plugins listed in each file
  { import = 'custom.plugins' }, -- Directory version
  -- { import 'custom.plugins.init'} -- File version containing table-list of plugin specs
}, {
  ui = {
    -- If using NerdFont, use its icons via empty table, otherwise use this Unicode table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- NOTE: This line below is a `modeline`. See `:help modeline` for major details
-- BUT simply, it sets up basic file options like `ts` for tabstop or `sw` for shiftwidth
-- `:help 'tabstop'` says this modeline is method 2 to setup tabs, i.e. change 'tabstop',
-- which sets # of spaces a tab equals, to your preference AS LONG AS 'expandtab' is set
-- AND 'softtabstop' and 'shiftwidth' are set to your preferred values.
-- 'softtabstop' makes tabs FEEL/WORK like spaces, e.g. if == 4, backspaces move 4 times
-- 'shiftwidth' seems to actually force spaces to be used on indent and auto-indent
-- Downside seems to be actual spaces are used instead of tabs (aka '\t')
-- vim: ts=2 sts=2 sw=2 et
