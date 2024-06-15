return {
  "Everblush/nvim",
  name = "everblush",
  priority = 1000, -- Ensure it loads first
  lazy = true,
  opts = {
    override = {
      -- Normal = { fg = "#ffffff", bg = "comment" },
    },
    transparent_background = false,
    nvim_tree = {
      contrast = true,
    },
  },
}
