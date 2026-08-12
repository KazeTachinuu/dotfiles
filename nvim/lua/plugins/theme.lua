-- nvim-only override: decoupled from omarchy desktop theme.
-- Restore omarchy control with: rm theme.lua && cp -P theme.lua.omarchy.bak theme.lua

-- Color printf format specifiers (%ld, %s, ...) with the theme's type color,
-- so they never blend into the string and stay in-palette in every theme.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "@character.printf", { link = "@type" })
  end,
})

return {
  { "loctvl842/monokai-pro.nvim", priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai-pro-machine",
    },
  },
}
