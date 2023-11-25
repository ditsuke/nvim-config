local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazy_path })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazy_path)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Extra lazyvim modules
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.ui.mini-starter" },
    { import = "lazyvim.plugins.extras.lang.clangd" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.ui.edgy" },
    -- { import = "lazyvim.plugins.extras.util.project" },

    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- { import = "lazyvim.plugins.extras.coding.copilot" },
    -- import/override with your plugins
    { import = "ditsuke.plugins" },
    { import = "ditsuke.plugins.editor" },
    { import = "ditsuke.plugins.ui" },

    -- Others
    { import = "ditsuke.extras.code.dap_extensions" },
    { import = "ditsuke.extras.code.neotest" },
    { import = "ditsuke.extras.utils.ai" },
    { import = "ditsuke.extras.utils.wakatime" },
    { import = "ditsuke.extras.prose" },
    { import = "ditsuke.extras.editor.auto_close_buffer" },

    -- Language extensions
    { import = "ditsuke.extras.lang.go" },
    { import = "ditsuke.extras.lang.java" },
    { import = "ditsuke.extras.lang.typescript" }, -- vs `lazyvim.plugins.extras.lang.typescript`, this one uses `vtsls` instead
    { import = "ditsuke.extras.lang.python" },
    -- { import = "lazyvim.plugins.extras.lang.rust" },
    { import = "ditsuke.extras.lang.rust" },
    { import = "ditsuke.extras.lang.yaml" },
    { import = "ditsuke.extras.lang.just" },
    { import = "ditsuke.extras.lang.dotenv" },
  },
  -- dev = { path = "~/projects", patterns = jit.os:find("Windows") and {} or { "LazyVim" } },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true, notify = false }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      -- https://github.com/ditsuke
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
