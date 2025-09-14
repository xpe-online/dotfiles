require("config.lazy")

vim.cmd.set "shiftwidth=2"
vim.cmd.set "softtabstop=2"
vim.cmd.colorscheme "catppuccin-mocha"
vim.opt.termguicolors = true
vim.notify = require("notify")
vim.cmd.set "relativenumber"
vim.opt.clipboard = "unnamedplus"

local lastplace = vim.api.nvim_create_augroup("LastPlace", {})
vim.api.nvim_clear_autocmds({ group = lastplace })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = lastplace,
    pattern = { "*" },
    desc = "remember last cursor place",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

vim.filetype.add({
  extension = {
    service = "service",
  }
})
vim.treesitter.language.register('ini', 'service')

require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "cpp", "python", "markdown", "javascript", "html", "css", "typescript", "json", "json5", "toml", "vue", "yaml", "xml", "ini" },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
}

require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing
  }
})

require('neo-tree').setup({
  window = {
    position = "float"
  }
})

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require("tiny-inline-diagnostic").setup({
    -- Style preset for diagnostic messages
    -- Available options: "modern", "classic", "minimal", "powerline", "ghost", "simple", "nonerdfont", "amongus"
    preset = "powerline",

    -- Set the background of the diagnostic to transparent
    transparent_bg = false,

    -- Set the background of the cursorline to transparent (only for the first diagnostic)
    -- Default is true in the source code, not false as in the old README
    transparent_cursorline = true,

    hi = {
        -- Highlight group for error messages
        error = "DiagnosticError",

        -- Highlight group for warning messages
        warn = "DiagnosticWarn",

        -- Highlight group for informational messages
        info = "DiagnosticInfo",

        -- Highlight group for hint or suggestion messages
        hint = "DiagnosticHint",

        -- Highlight group for diagnostic arrows
        arrow = "NonText",

        -- Background color for diagnostics
        -- Can be a highlight group or a hexadecimal color (#RRGGBB)
        background = "CursorLine",

        -- Color blending option for the diagnostic background
        -- Use "None" or a hexadecimal color (#RRGGBB) to blend with another color
        -- Default is "Normal" in the source code
        mixing_color = "Normal",
    },

    options = {
        -- Display the source of the diagnostic (e.g., basedpyright, vsserver, lua_ls etc.)
        show_source = {
            enabled = false,
            -- Show source only when multiple sources exist for the same diagnostic
            if_many = false,
        },

        -- Use icons defined in the diagnostic configuration instead of preset icons
        use_icons_from_diagnostic = false,

        -- Set the arrow icon to the same color as the first diagnostic severity
        set_arrow_to_diag_color = false,

        -- Add messages to diagnostics when multiline diagnostics are enabled
        -- If set to false, only signs will be displayed
        add_messages = true,

        -- Time (in milliseconds) to throttle updates while moving the cursor
        -- Increase this value for better performance on slow computers
        -- Set to 0 for immediate updates and better visual feedback
        throttle = 20,

        -- Minimum message length before wrapping to a new line
        softwrap = 30,

        -- Configuration for multiline diagnostics
        -- Can be a boolean or a table with detailed options
        multilines = {
            -- Enable multiline diagnostic messages
            enabled = false,

            -- Always show messages on all lines for multiline diagnostics
            always_show = false,

            -- Trim whitespaces from the start/end of each line
            trim_whitespaces = false,

            -- Replace tabs with this many spaces in multiline diagnostics
            tabstop = 4,
        },

        -- Display all diagnostic messages on the cursor line, not just those under cursor
        show_all_diags_on_cursorline = false,

        -- Enable diagnostics in Insert mode
        -- If enabled, consider setting throttle to 0 to avoid visual artifacts
        enable_on_insert = false,

        -- Enable diagnostics in Select mode (e.g., when auto-completing with Blink)
        enable_on_select = false,

        -- Manage how diagnostic messages handle overflow
        overflow = {
            -- Overflow handling mode:
            -- "wrap" - Split long messages into multiple lines
            -- "none" - Do not truncate messages
            -- "oneline" - Keep the message on a single line, even if it's long
            mode = "wrap",

            -- Trigger wrapping this many characters earlier when mode == "wrap"
            -- Increase if the last few characters of wrapped diagnostics are obscured
            padding = 0,
        },

        -- Configuration for breaking long messages into separate lines
        break_line = {
            -- Enable breaking messages after a specific length
            enabled = false,

            -- Number of characters after which to break the line
            after = 30,
        },

        -- Custom format function for diagnostic messages
        -- Function receives a diagnostic object and should return a string
        -- Example: function(diagnostic) return diagnostic.message .. " [" .. diagnostic.source .. "]" end
        format = nil,

        -- Virtual text display configuration
        virt_texts = {
            -- Priority for virtual text display (higher values appear on top)
            -- Increase if other plugins (like GitBlame) override diagnostics
            priority = 2048,
        },

        -- Filter diagnostics by severity levels
        -- Available severities: vim.diagnostic.severity.ERROR, WARN, INFO, HINT
        severity = {
            vim.diagnostic.severity.ERROR,
            vim.diagnostic.severity.WARN,
            vim.diagnostic.severity.INFO,
            vim.diagnostic.severity.HINT,
        },

        -- Events to attach diagnostics to buffers
        -- Default: { "LspAttach" }
        -- Only change if the plugin doesn't work with your configuration
        overwrite_events = nil,
    },

    -- List of filetypes to disable the plugin for
    disabled_ft = {}
})
