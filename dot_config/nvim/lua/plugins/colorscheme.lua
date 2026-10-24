return {
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nord_italic = false  -- keep italics off, matching the rest of the setup
      require('nord').set()
    end,
  },
}
