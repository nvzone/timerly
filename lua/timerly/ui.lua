local M = {}
local api = require "timerly.api"
local state = require "timerly.state"
local voltui = require "volt.ui"
local redraw = require("volt").redraw
local utils = require "timerly.utils"

M.clock = function()
  return state.clock
end

M.progress = function()
  local lines = voltui.progressbar {
    w = state.w_with_pad,
    val = state.progress,
    icon = { on = "|", off = "|" },
  }

  return { lines }
end

M.actionbtns = function()
  local btn1mode = state.mode == "start"
  local btn1txt = btn1mode and "  Pause" or "  Start"

  local hovermark = vim.g.nvmark_hovered
  local btn1 = {
    btn1txt,
    hovermark == "tbtn1" and "ExRed" or "Normal",

    {
      hover = { id = "tbtn1", redraw = "actionbtns" },
      click = btn1mode and api.pause or api.start,
    },
  }

  local resetbtn = {
    "  Reset ",
    hovermark == "tbtn2" and "normal" or "Exblue",
    {

      hover = { id = "tbtn2", redraw = "actionbtns" },
      click = api.reset,
    },
  }

  local pad = { string.rep(" ", 7) }

  local plusbtn = {
    "",
     hovermark == "tbtn3" and "normal" or "exgreen",
    {
      hover = { id = "tbtn3", redraw = "actionbtns" },
      click = api.increment,
    },
  }

  local minbtn = {
    "",
    hovermark == "tbtn4" and "normal" or "exred",
    {
      hover = { id = "tbtn4", redraw = "actionbtns" },
      click = api.decrement,
    },
  }

  return {
    { btn1, pad, minbtn, { "  " }, plusbtn, pad, resetbtn },
  }
end

return M
