return {
  "NvChad/nvterm",
  config = function()
    require("nvterm").setup({
      terminals = {
        shell = vim.o.shell,
        list = {},
        type_opts = {
          float = {
            relative = "window",
            row = 0.2,
            col = 0.15,
            width = 0.7,
            height = 0.6,
            border = "rounded",
          },
          horizontal = { location = "rightbelow", split_ratio = 0.3 },
          vertical = { location = "rightbelow", split_ratio = 0.5 },
        },
      },
      behavior = {
        autoclose_on_quit = {
          enabled = false,
          confirm = true,
        },
        close_on_exit = true,
        auto_insert = true,
      },
    })

    local toggle_modes = { "n", "t" }
    local mappings = {
      {
        toggle_modes,
        "<A-h>",
        function()
          require("nvterm.terminal").toggle("horizontal")
        end,
      },
      {
        toggle_modes,
        "<A-v>",
        function()
          require("nvterm.terminal").toggle("vertical")
        end,
      },
      {
        toggle_modes,
        "<A-i>",
        function()
          require("nvterm.terminal").toggle("float")
        end,
      },
    }
    local opts = { noremap = true, silent = true }
    for _, mapping in ipairs(mappings) do
      vim.keymap.set(mapping[1], mapping[2], mapping[3], opts)
    end
  end,
  keys = {
    {
      "<leader>th",
      function()
        require("nvterm.terminal").new("horizontal")
      end,
      desc = "Open new horizontal terminal",
    },
    {
      "<leader>tv",
      function()
        require("nvterm.terminal").new("vertical")
      end,
      desc = "Open new vertical terminal",
    },
    {
      "<leader>ti",
      function()
        require("nvterm.terminal").new("float")
      end,
      desc = "Open new float terminal",
    },
  },
}
