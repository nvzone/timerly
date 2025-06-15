local M = {}
local state = require "timerly.state"
local ascii = require "timerly.ascii"
local redraw = require("volt").redraw
local api = vim.api

M.secs_to_ascii = function(n)
  if state.minutes > 59 then
    state.minutes = 25
    n = 25 * 60
    vim.notify "Timerly: you can't set a time longer than 25 minutes"
  end

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
      state.progress = math.floor((total_secs / (state.minutes * 60)) * 100)
      state.progress = 100 - state.progress
      M.secs_to_ascii(total_secs)

      if total_secs > 0 then
        total_secs = total_secs - 1
      else
        state.timer:stop()
        state.config.on_finish()
        state.status = ""
      end

      redraw(state.buf, "clock")
      redraw(state.buf, "progress")

      state.total_secs = total_secs
    end)
  )
end

M.set_position = function(position)
  local columns = vim.o.columns
  local lines = vim.o.lines

  if type(position) == "function" then
    return position(state.w, state.h)
  end

  if position == "center" then
    local centered_col = math.floor((columns / 2) - (state.w / 2))
    -- 3 cuz height of input win , 2 for timer win top/bot border
    local centered_row = math.floor((lines - (state.h + 3 + 2)) / 2)
    return centered_row, centered_col
  elseif position == "top-left" then
    return 1, 2
  elseif position == "top-right" then
    return 1, columns - state.w - 4
  elseif position == "bottom-left" then
    return lines - state.h - 8, 2
  elseif position == "bottom-right" then
    return lines - state.h - 8, columns - state.w - 4
  end
end

M.openwins = function()
  local row, col = M.set_position(state.config.position)

  state.buf = state.buf or api.nvim_create_buf(false, true)

  state.win = api.nvim_open_win(state.buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = state.w,
    height = state.h,
    style = "minimal",
    border = "single",
  })

  state.input_buf = state.input_buf or api.nvim_create_buf(false, true)

  state.input_win = api.nvim_open_win(state.input_buf, true, {
    row = state.h + 1,
    col = -1,
    width = state.w,
    height = 1,
    relative = "win",
    win = state.win,
    style = "minimal",
    border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
  })

  vim.bo[state.input_buf].buftype = "prompt"
  vim.fn.prompt_setprompt(state.input_buf, " 󰄉  Enter time: ")
  vim.wo[state.input_win].winhl = "Normal:ExBlack2Bg,FloatBorder:ExBlack2Border"

  api.nvim_win_set_hl_ns(state.win, state.ns)
  api.nvim_set_hl(state.ns, "Normal", { link = "ExdarkBg" })
  api.nvim_set_hl(state.ns, "FLoatBorder", { link = "Exdarkborder" })

  vim.cmd.startinsert()

  vim.schedule(function()
    api.nvim_set_current_win(state.win)
  end)
end

return M
