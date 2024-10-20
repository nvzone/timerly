local M = {
  timer = vim.uv.new_timer(),
  clock = nil,
  xpad = 3,
  progress = 0,

  config = {
    minutes = 10,
    on_finish = function()
      vim.notify "Timerly: time's up!"
    end,
  },

  status = "", -- or pause
}

return M
