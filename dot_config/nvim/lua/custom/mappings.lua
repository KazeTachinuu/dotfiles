---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

M.custom = {
  n = {
    ["<c-a>"] = { "gg<S-v>G", "Select All" },
    --transparency
    ["<leader>to"] = { ":lua require('base46').toggle_transparency()<CR>", "Toggle Transparency" },
    --theme
    ["<leader>tt"] = { ":lua require('base46').toggle_theme()<CR>", "Toggle Theme" },
    --split horizontal
    ["<leader>sh"] = { ":split<CR>", "Split Horizontal" },
    --split vertical
    ["<leader>sv"] = { ":vsplit<CR>", "Split Vertical" },
    --kill buffer
    ["<leader>bd"] = { ":bd<CR>", "Kill Buffer" },
  },
}

-- more keybinds!

return M
