local utils = require "timerly.utils"
local state = require "timerly.state"
local api = vim.api
local volt = require "volt"
local volt_events = require "volt.events"
local timerlyapi = require "timerly.api"

state.ns = api.nvim_create_namespace "Timerly"

local M = {}

M.open = function()
  state.volt_set = true
  local config = state.config
  state.minutes = config.minutes[1]

  utils.secs_to_ascii(state.minutes * 60)

  state.w = 24 + 2 + (2 * 4) + (2 * state.xpad)
  state.w_with_pad = state.w - (2 * state.xpad)

  utils.openwins()

  vim.fn.prompt_setcallback(state.input_buf, function(input)
    local n = tonumber(input)
    if type(n) == "number" then
      state.minutes = n
      timerlyapi.reset()
    end
  end)

  volt.gen_data {
    {
      buf = state.buf,
      layout = require "timerly.layout",
      xpad = state.xpad,
      ns = state.ns,
    },
  }

  volt.run(state.buf, { h = state.h, w = state.w })
  volt_events.add(state.buf)

  volt.mappings {
    bufs = { state.buf, state.input_buf },
    input_buf = state.input_buf,
    after_close = function()
      state.timer:stop()
      state.buf = nil
      state.input_buf = nil
      state.volt_set = false
    end,
  }
end

M.toggle = function()
  if not state.volt_set then
    M.open()
  elseif state.visible then
    api.nvim_win_close(state.win, true)
    api.nvim_win_close(state.input_win, true)
  else
    utils.openwins()
  end

  state.visible = not state.visible
end

return M
