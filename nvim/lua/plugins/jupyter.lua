return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- These are examples from the guide to get you started
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
  },
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- Change this if you are not using Kitty (e.g., "ueberzug")
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge, -- Required for Molten to render correctly
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- Toggles images when windows overlap
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },

  -- 3. QUARTO + OTTER (The "UI" & LSP)
  -- This provides the "cell" experience and syncs your code with LSP (pyright, etc.)
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim", -- Handles LSP injection
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "quarto", "markdown" }, -- Load on these filetypes
    config = function()
      require("quarto").setup({
        lspFeatures = {
          enabled = true,
          chunks = "all", -- Auto-enable LSP in code chunks
          languages = { "python", "lua" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        keymap = {
          -- Quarto gives you 'cells' implicitly.
          -- Use standard bindings to navigate them:
          -- ]c : next cell
          -- [c : prev cell
          hover = "K",
          definition = "gd",
        },
      })
    end,
  },
}
