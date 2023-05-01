local Util = require("ditsuke.utils")

return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local null_ls = require("null-ls")
      Util.list_insert_unique(opts.sources, {
        null_ls.builtins.code_actions.proselint,
        null_ls.builtins.diagnostics.cspell,
        null_ls.builtins.code_actions.cspell,
      })
      return opts
    end,
  },
}
