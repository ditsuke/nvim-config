local jdtls_opts = function()
  return {
    cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
    settings = {
      java = {
        configuration = {
          runtimes = {
            {
              name = "JavaSE-17",
              path = "/usr/lib/jvm/java-17-openjdk-17.0.6.0.10-1.fc37.x86_64/",
            },
          },
        },
      },
    },
  }
end

local function setup_jdtls()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function()
      local jdtls = require("jdtls")
      local wk = require("which-key")
      local bufnr = vim.api.nvim_get_current_buf()

      local extract_variable = function() jdtls.extract_variable(true) end
      local extract_method = function() jdtls.extract_method(true) end

      wk.register({
        ["<leader>cJ"] = { name = "+java", buffer = bufnr, mode = { "n", "v" } },
      })

      wk.register({
        i = { jdtls.organize_importsorganize_imports, "Organize imports" },
        t = { jdtls.test_class, "Test class" },
        n = { jdtls.test_nearest_method, "Test nearest method" },
        e = { extract_variable, "Extract variable" },
        M = { extract_method, "Extract method" },
      }, {
        prefix = "<leader>cJ",
        buffer = bufnr,
      })

      wk.register({
        e = { extract_variable, "Extract variable" },
        M = { extract_method, "Extract method" },
      }, {
        mode = "v",
        prefix = "<leader>cJ",
        buffer = bufnr,
      })

      jdtls.start_or_attach(jdtls_opts())
      jdtls.setup_dap({ hotcodereplace = "auto" })
    end,
  })

  return true
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = {
      setup = {
        jdtls = setup_jdtls,
      },
    },
  },
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   ft = "java",
  --   opts = function()
  --     return {
  --       cmd = { vim.fn.stdpath("data") .. "/mason/bin/jdtls" },
  --       root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
  --       settings = {
  --         configuration = {
  --           runtimes = {
  --             {
  --               name = "JavaSE-17",
  --               path = "/usr/lib/jvm/java-17-openjdk-17.0.6.0.10-1.fc37.x86_64/",
  --             },
  --           },
  --         },
  --       },
  --     }
  --   end,
  --   config = function(_, opts) require("jdtls").start_or_attach(opts) end,
  -- },
}
