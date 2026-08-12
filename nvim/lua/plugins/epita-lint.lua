return {
  {
    "KazeTachinuu/epita-nvim-lint",
    dependencies = { "mfussenegger/nvim-lint" },
    config = function()
      require("epita-nvim-lint").setup()
    end,
  },
}
