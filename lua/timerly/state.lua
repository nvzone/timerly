local M = {
  timer = vim.uv.new_timer(),
  clock = nil,
  xpad = 3,
  progress = 0,
  mode = "focus",
  minutes = 10,

  config = {
    minutes = { 25, 5 },
    on_finish = function()
      vim.notify "Timerly: time's up!"
    end,
  },

  status = "", -- or pause
}

return M
