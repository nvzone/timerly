local M = {}
local utils = require "timerly.utils"
local state = require "timerly.state"
local redraw = require("volt").redraw

M.start = function()
  if state.config.on_start then
    state.config.on_start()
  end

  local mins = state.status == "pause" and (state.total_secs / 60) or state.minutes
  utils.start(mins)
  state.status = "start"
end

M.reset = function()
  state.progress = 0
  state.status = ""
  state.timer:stop()
  utils.secs_to_ascii(state.minutes * 60)
  redraw(state.buf, "clock")
  redraw(state.buf, "progress")
  redraw(state.buf, "actionbtns")
end

M.pause = function()
  state.status = "pause"
  state.timer:stop()
end

M.increment = function()
  state.minutes = state.minutes + 1
  M.reset()
end

M.decrement = function()
  if state.minutes == 0 then return end
  state.minutes = state.minutes - 1
  M.reset()
end

M.togglemode = function()
  local focusmode = state.mode == "focus"
  state.mode = (focusmode and "break") or "focus"
  state.minutes = state.config.minutes[focusmode and 2 or 1]
  redraw(state.buf, "modes")
  M.reset()
end

M.togglestatus = function()
  M[state.status == "start" and "pause" or "start"]()
  redraw(state.buf, "actionbtns")
end

return M
