return {
  "loctvl842/monokai-pro.nvim",
  lazy = true,
  priority = 1000, -- Ensure it loads first
  opts = {
    transparent_background = false,
    terminal_colors = true,
    devicons = true, -- highlight the icons of `nvim-web-devicons`
    styles = {
      comment = { italic = true },
      keyword = { italic = true, bold = true }, -- any other keyword
      type = { italic = true }, -- (preferred) int, long, char, etc
      storageclass = { italic = true }, -- static, register, volatile, etc
      structure = { italic = true }, -- struct, union, enum, etc
      parameter = {}, -- parameter pass in function
      annotation = {},
      tag_attribute = { italic = true }, -- attribute of tag in reactjs
    },
    filter = "classic",
    override = function()
      return {
        Normal = { bg = "#1e2128" },
      }
    end,
  },
}
