local Ufo = {
  "kevinhwang91/nvim-ufo",
  enabled = true,
  event = { "BufReadPost", "InsertEnter" },
  dependencies = { "kevinhwang91/promise-async" },
  keys = {
    {
      "zR",
      function() require("ufo").openAllFolds() end,
      desc = "Open all folds",
    },
    {
      "zM",
      function() require("ufo").closeAllFolds() end,
      desc = "Close all folds",
    },
    {
      "zr",
      function() require("ufo").openFoldsExceptKinds() end,
      desc = "Fold less",
    },
    {
      "zm",
      function() require("ufo").closeFoldsWith() end,
      desc = "Fold more",
    },
    {
      "zp",
      function() require("ufo").peekFoldedLinesUnderCursor() end,
      desc = "Peek fold",
    },
  },
}

local function provider_selector(_, filetype, buftype)
  local function handleFallbackException(bufnr, err, providerName)
    if type(err) == "string" and err:match("UfoFallbackException") then
      return require("ufo").getFolds(bufnr, providerName)
    else
      return require("promise").reject(err)
    end
  end

  return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
    or function(bufnr)
      return require("ufo")
        .getFolds(bufnr, "lsp")
        :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
        :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
    end
end

Ufo.opts = function(_, _)
  return {
    preview = {
      mappings = {
        scrollB = "<C-b>",
        scrollF = "<C-f>",
        scrollU = "<C-u>",
        scrollD = "<C-d>",
      },
    },
    provider_selector = provider_selector,
  }
end

Ufo.init = function()
  vim.o.foldcolumn = "1" -- '0' is not bad
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
end

return Ufo
