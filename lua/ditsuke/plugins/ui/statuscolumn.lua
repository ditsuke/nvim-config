local Icons = require("ditsuke.utils.icons")

local function get_git_sign()
  return vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
    group = "gitsigns_vimfn_signs_",
    lnum = vim.v.lnum,
  })[1].signs[1]
end

local highlights_cache = {}

local function get_gitsign_highlight()
  local sign = get_git_sign()
  if sign then
    if not highlights_cache[sign.name] then
      highlights_cache[sign.name] = vim.fn.sign_getdefined(sign.name)[1].texthl
    end

    return highlights_cache[sign.name]
  else
    return "StatusColumnBorder"
  end
end

-- stylua: ignore
local function component_sign_border()
  return table.concat({ "%#", get_gitsign_highlight(), "#", Icons.misc.v_border, "%*" })
end

return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      ft_ignore = {
        "neo-tree",
        "starter",
      },
      relculright = true,
      segments = {
        {
          sign = { name = { "Diagnostic" }, maxwidth = 1, auto = false },
          click = "v:lua.ScSa",
        },
        { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
        -- TODO: Add fold display
        -- {
        --   text = { builtin.foldfunc },
        --   click = "v:lua.ScFa",
        -- },
        {
          text = { component_sign_border, " " },
          sign = {
            name = { "GitSigns" },
            maxwidth = 2,
            colwidth = 1,
            auto = false,
            wrap = true,
          },
          click = "v:lua.ScSa",
        },
      },
    })
  end,
}
