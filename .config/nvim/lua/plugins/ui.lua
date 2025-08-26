return{
  {
    "rcarriga/nvim-notify",
    opts = {
      stages = "fade",
      fps = 60,
      vim.cmd.highlight "NotifyERRORBorder guifg=#A33F58",
      vim.cmd.highlight "NotifyWARNBorder guifg=#B06289",
      vim.cmd.highlight "NotifyINFOBorder guifg=#B378AA",
      vim.cmd.highlight "NotifyDEBUGBorder guifg=#997A84",
      vim.cmd.highlight "NotifyTRACEBorder guifg=#965FAF",
      vim.cmd.highlight "NotifyERRORIcon guifg=#E75A7C",
      vim.cmd.highlight "NotifyWARNIcon guifg=#F087BD",
      vim.cmd.highlight "NotifyINFOIcon guifg=#F2A2E8",
      vim.cmd.highlight "NotifyDEBUGIcon guifg=#D1A6B4",
      vim.cmd.highlight "NotifyTRACEIcon guifg=#D484FF",
      vim.cmd.highlight "NotifyERRORTitle guifg=#E75A7C",
      vim.cmd.highlight "NotifyWARNTitle guifg=#F087BD",
      vim.cmd.highlight "NotifyINFOTitle guifg=#F2A2E8",
      vim.cmd.highlight "NotifyDEBUGTitle guifg=#D1A6B4",
      vim.cmd.highlight "NotifyTRACETitle guifg=#D484FF",
      vim.cmd.highlight "link NotifyERRORBody Normal",
      vim.cmd.highlight "link NotifyWARNBody Normal",
      vim.cmd.highlight "link NotifyINFOBody Normal",
      vim.cmd.highlight "link NotifyDEBUGBody Normal",
      vim.cmd.highlight "link NotifyTRACEBody Normal"
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "folke/snacks.nvim",
    },
    lazy = false,
    opts = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
	{ event = events.FILE_MOVED, handler = on_move },
	{ event = events.FILE_RENAMED, handler = on_move },
      })
      vim.cmd.map "<F12> :Neotree float<CR>"
      vim.cmd.map "<C-F12> :Neotree close<CR>"
    end,
  },
  {
    "sindrets/diffview.nvim",
    opts = {
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  }
}
