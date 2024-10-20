local M = {}
local state = require "timerly.state"
local ascii = require "timerly.ascii"
local redraw = require("volt").redraw

M.secs_to_ascii = function(n)
  local mins = n / 60 -- Make sure mins is an integer
  local secs = n % 60

  local nums = {
    math.floor(mins / 10) + 1,
    math.floor(mins % 10) + 1,
    11,
    math.floor(secs / 10) + 1,
    math.floor(secs % 10) + 1,
  }

  local abc = { {}, {}, {}, {}, {} }

  for i = 1, 5 do
    local numascii = ascii[nums[i]]

    local hlgroup = "Exgreen"

    if i > 3 then
      hlgroup = "linenr"
    end

    for row = 1, 5 do
      if i ~= 1 then
        table.insert(abc[row], { "  " })
      end

      table.insert(abc[row], { numascii[row], hlgroup })
    end
  end

  state.clock = abc
end

M.start = function(minutes)
  local total_secs = minutes * 60

  state.timer:start(
    0,
    1000,
    vim.schedule_wrap(function()
      state.progress = math.floor((total_secs / (state.config.minutes * 60)) * 100)
      state.progress = 100 - state.progress

      if total_secs > 0 then
        M.secs_to_ascii(total_secs)
        total_secs = total_secs - 1
      else
        state.timer:stop()
      end

      redraw(state.buf, "clock")
      redraw(state.buf, "progress")

      state.total_secs = total_secs
    end)
  )
end

return M
