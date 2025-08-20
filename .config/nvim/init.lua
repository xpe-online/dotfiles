require("config.lazy")

vim.cmd.set "shiftwidth=2"
vim.cmd.set "softtabstop=2"
vim.cmd.colorscheme "catppuccin-mocha"
vim.opt.termguicolors = true
vim.notify = require("notify")

require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "cpp", "python", "markdown", "javascript", "html", "css", "typescript", "json", "json5", "toml", "vue", "yaml", "xml" },
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
    enable_close_on_slash = false -- Auto close on trailing </
  }
})

require('neo-tree').setup({
  window = {
    position = "float"
  }
})

