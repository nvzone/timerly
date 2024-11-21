local state = require "timerly.state"
local map = vim.keymap.set
local api = vim.api
local myapi = require "timerly.api"

return function()
  -- drag window
  map("n", "<LeftDrag>", function()
    local mouse_pos = vim.fn.getmousepos()

    api.nvim_win_set_config(state.win, {
      relative = "editor",
      row = mouse_pos.screenrow - 1,
      col = mouse_pos.screencol - 1,
    })

    vim.api.nvim_win_set_config(state.input_win, {
      relative = "win",
      row = state.h + 1,
      col = -1,
    })
  end, { buffer = state.buf })

  map("n", "m", myapi.togglemode, { buffer = state.buf })
  map("n", "<leader>", myapi.togglestatus, { buffer = state.buf })
  map("n", "<up>", myapi.increment, { buffer = state.buf })
  map("n", "<down>", myapi.decrement, { buffer = state.buf })
  map("n", "<BS>", myapi.reset, { buffer = state.buf })

  if state.config.mapping then
    state.config.mapping(state.buf)
  end
end
