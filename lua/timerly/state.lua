local M = {
  visible = false,
  volt_set = false,
  timer = vim.uv.new_timer(),
  clock = nil,
  xpad = 3,
  progress = 0,
  mode = "focus",
  minutes = 10,
  h = 14,

  config = {
    minutes = { 25, 5 },
    on_start = nil, -- func
    on_finish = function()
      vim.notify "Timerly: time's up!"
    end,
    mapping = nil, -- is func
    position = "center", -- top-left, top-right, bottom-left, bottom-right
    -- or function(w, h) return row, col end , w - w of window, arg passed by plugin
  },

  status = "", -- or pause
}

return M
