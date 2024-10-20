local M = {
  timer = vim.uv.new_timer(),
  clock = nil,
  xpad = 3,
  progress = 0,

  config = {
    minutes = 10,
  },

  mode = "", -- or pause
}

return M
