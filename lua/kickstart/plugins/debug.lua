-- NOTE: Configures a debugger used by any language you want with the right adapters!

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui', -- Nice debugger UI
    'nvim-neotest/nvim-nio', -- Helps `nvim-dap-ui`

    'williamboman/mason.nvim', -- Used to install adapters
    'jay-babu/mason-nvim-dap.nvim',

    'leoluz/nvim-dap-go', -- Go's Debug Adapter
  },
  keys = {
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>b',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>B',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Debug: Set Breakpoint',
    },
    { -- If tests fail, use this to figure out what failed
      '<F7>',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: See last session result.',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      automatic_installation = true, -- Like Mason, auto-add adapters for us!
      handlers = {}, -- Also like Mason, add funcs for additional setup
      ensure_installed = { -- Some additional lang dependencies may need to be added here!
        'delve', -- Go needs this to actually debug
      },
    }
    dapui.setup { -- For more Dap-UI setup info see `:h nvim-dap-ui`
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-go').setup { -- Golang specific UI config
      delve = { -- Must run attached if on Windows - See `nvim-dap-go` README
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
