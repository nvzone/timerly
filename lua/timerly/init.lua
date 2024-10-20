local utils = require "timerly.utils"
local state = require "timerly.state"
local api = vim.api
local volt = require "volt"
local volt_events = require "volt.events"
state.ns = api.nvim_create_namespace "Timerly"
local timerlyapi = require "timerly.api"

local M = {}

M.open = function()
  state.buf = api.nvim_create_buf(false, true)
  local h = 11

  utils.secs_to_ascii(state.config.minutes * 60)

  state.w = 24 + 2 + (2 * 4) + (2 * state.xpad)
  state.w_with_pad = state.w - (2 * state.xpad)

  local centered_col = math.floor((vim.o.columns / 2) - (state.w / 2))
  local centered_row = math.floor((vim.o.lines / 2) - (h / 2))

  local win = api.nvim_open_win(state.buf, true, {
    relative = "editor",
    row = centered_row,
    col = centered_col,
    width = state.w,
    height = h,
    style = "minimal",
    border = "single",
  })

  state.input_buf = api.nvim_create_buf(false, true)

  local input_win = api.nvim_open_win(state.input_buf, true, {
    row = h + 1,
    col = -1,
    width = state.w,
    height = 1,
    relative = "win",
    win = win,
    style = "minimal",
    border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
  })

  vim.bo[state.input_buf].buftype = "prompt"
  vim.fn.prompt_setprompt(state.input_buf, " 󰄉  Enter time: ")
  vim.wo[input_win].winhl = "Normal:ExBlack2Bg,FloatBorder:ExBlack2Border"

  vim.fn.prompt_setcallback(state.input_buf, function(input)
    local n = tonumber(input)
    if (type(n) == 'number') then
      state.config.minutes = n
      timerlyapi.reset()
    end
  end)

  vim.cmd "startinsert"

  api.nvim_win_set_hl_ns(win, state.ns)
  api.nvim_set_hl(state.ns, "Normal", { link = "ExdarkBg" })
  api.nvim_set_hl(state.ns, "FLoatBorder", { link = "Exdarkborder" })

  local ns = api.nvim_create_namespace "NVTimer"

  volt.gen_data {
    {
      buf = state.buf,
      layout = require "timerly.layout",
      xpad = state.xpad,
      ns = ns,
    },
  }

  volt.run(state.buf, { h = h, w = state.w })
  -- utils.start(state.config.minutes)
  volt_events.add(state.buf)

  volt.mappings {
    bufs = { state.buf, state.input_buf },
    input_buf = state.input_buf,
    after_close = function()
      state.timer:stop()
    end,
  }
end

return M
