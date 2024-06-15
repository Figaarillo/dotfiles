if true then
  return {}
end

return {
  "uloco/bluloco.nvim",
  lazy = true,
  priority = 1000,
  dependencies = { "rktjmp/lush.nvim" },
  opts = {
    style = "auto", -- "auto" | "dark" | "light"
    transparent = false,
    italics = true,
    terminal = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
    guicursor = true,
  },
}
