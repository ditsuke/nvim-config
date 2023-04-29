local M = {}

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))

  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

--- Get completion context, i.e., auto-import/target module location.
--- Depending on the LSP this information is stored in different parts of the
--- lsp.CompletionItem payload. The process to find them is very manual: log the payloads
--- And see where useful information is stored.
---@param completion lsp.CompletionItem
---@param source cmp.Source
---@see Astronvim, because i just discovered they're already doing this thing, too
--  https://github.com/AstroNvim/AstroNvim
local function get_lsp_completion_context(completion, source)
  local ok, source_name = pcall(function() return source.source.client.config.name end)
  if not ok then return nil end
  if source_name == "tsserver" then
    return completion.detail
  elseif source_name == "pyright" or source_name == "vtsls" then
    if completion.labelDetails ~= nil then return completion.labelDetails.description end
  elseif source_name == "gopls" then
    -- And this, for the record, is how I inspect payloads
    -- require("ditsuke.config.shared").logger("completion source: ", completion) -- Lazy-serialization of heavy payloads
    -- require("ditsuke.config.shared").logger("completion detail added to gopls")
    return completion.detail
  end
end

local SYMBOL_MAP = {
  Text = "  ",
  Method = "  ",
  Function = "  ",
  Constructor = "  ",
  Field = "  ",
  Variable = "  ",
  Class = "  ",
  Interface = "  ",
  Module = "  ",
  Property = "  ",
  Unit = " 塞",
  Value = "  ",
  Enum = "  ",
  Keyword = "  ",
  Snippet = "  ",
  Color = "  ",
  File = "  ",
  Reference = "  ",
  Folder = "  ",
  EnumMember = "  ",
  Constant = "  ",
  Struct = "  ",
  Event = "  ",
  Operator = "  ",
  TypeParameter = "  ",
}

M.config = function(_, _)
  local cmp = require("cmp")

  local editorSources = {
    {
      { name = "nvim_lsp", dup = 0 },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "emoji" },
    },
    {
      { name = "treesitter" },
      { name = "path" },
      -- Distracting!
      -- { name = "spell" },
      -- { name = "dictionary" },
    },
  }

  local WIN_HIGHLIGHT = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:Search"

  -- <Tab> is used by Copilot, I found the plugin doesn't work
  -- if I use <Tab> for nvim-cmp or any other plugin
  -- local mappings for nvim-cmp.
  local mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.mapping.complete({})
      else
        fallback()
      end
    end, { "i", "s", "c" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s", "c" }),
    -- ["<C-j>"] = cmp.mapping(function(fallback)
    --   if luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
    -- ["<C-k>"] = cmp.mapping(function(fallback)
    --   if luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { "i", "s" }),
    ["<C-Space>"] = cmp.mapping.complete({}),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }

  -- cmp plugin
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "cmp_git" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "nvim_lsp_document_symbol" },
      { name = "buffer" },
      { name = "dictionary" },
      { name = "spell" },
      { name = "path" },
    }),
  })

  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lsp_document_symbol" },
      { name = "dictionary" },
      { name = "buffer" },
    },
  })

  ---@type cmp.ConfigSchema
  cmp.setup.cmdline(":", {
    completion = {
      autocomplete = { "InsertEnter" },
    },
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "cmdline" },
      { name = "path", options = { trailing_slash = true, label_trailing_slash = true } },
      { name = "dictionary" },
      { name = "buffer" },
    }),
  })

  return {
    completion = {
      -- autocomplete = false, -- Can turn off autocomplete for ya
      -- completeopt = "menu,menuone,noinsert", -- No effect, but major SIDE-effect: selects first item visually, impairing `cmp` in command mode
    },
    experimental = {
      ghost_text = {
        hl_group = "LspCodeLens",
      },
      --   native_menu = true,
    },
    snippet = {
      expand = function(args) require("luasnip").lsp_expand(args.body) end,
    },
    window = {
      max_width = 40,
      col_offset = -3,
      side_padding = 0,
      completion = cmp.config.window.bordered({ winhighlight = WIN_HIGHLIGHT }),
      documentation = cmp.config.window.bordered({ winhighlight = WIN_HIGHLIGHT }),
      preview = cmp.config.window.bordered({ winhighlight = WIN_HIGHLIGHT }),
    },
    formatting = {
      --- @type cmp.ItemField[]
      fields = { "abbr", "kind", "menu" },

      --- @param entry cmp.Entry
      --- @param vim_item vim.CompletedItem
      format = function(entry, vim_item)
        local item_with_kind = require("lspkind").cmp_format({
          mode = "symbol",
          maxwidth = 50,
          symbol_map = SYMBOL_MAP,
        })(entry, vim_item)

        item_with_kind.menu = ""
        local completion_context = get_lsp_completion_context(entry.completion_item, entry.source)
        if completion_context ~= nil and completion_context ~= "" then
          local truncated_context = string.sub(completion_context, 1, 30)
          if truncated_context ~= completion_context then truncated_context = truncated_context .. "..." end
          item_with_kind.menu = item_with_kind.menu .. " " .. truncated_context
        end

        item_with_kind.menu_hl_group = "CmpItemAbbr"
        return item_with_kind
      end,
    },
    mapping = cmp.mapping.preset.insert(mapping),
    sources = cmp.config.sources(editorSources[1], editorSources[2]),
  }
end

return M
