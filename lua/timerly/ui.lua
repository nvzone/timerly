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
  local btn1txt = btn1mode and "  Pause" or "  Resume"
  btn1txt = state.mode == "" and "  Start " or btn1txt

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
    hovermark == "tbtn2" and "normal" or "Exred",
    {

      hover = { id = "tbtn2", redraw = "actionbtns" },
      click = api.reset,
    },
  }

  return {
    { btn1, { string.rep(" ", (state.mode == "pause" or state.mode == "") and 17 or 18) }, resetbtn },
  }
end

return M
