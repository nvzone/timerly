local M = {}
local api = require "timerly.api"
local state = require "timerly.state"
local voltui = require "volt.ui"
local redraw = require("volt").redraw
local utils = require "timerly.utils"

M.modes = function()
  local hovermark = vim.g.nvmark_hovered
  local mode = state.mode

  local focus_m = {
    "   Focus ",
    ((mode == "focus" or hovermark == "focus_m") and "exgreen") or "comment",
    {
      hover = { id = "focus_m", redraw = "modes" },
      click = api.setmode,
    },
  }

  local break_m = {
    " 󰒲  Break",
    ((mode == "break" or hovermark == "break_m") and "exgreen") or "comment",
    {

      hover = { id = "break_m", redraw = "modes" },
      click = api.setmode,
    },
  }


  return {
    { { "│ ", "comment" }, { "󰀘  Modes     " },  focus_m, break_m, { " │", "comment" } },
  }
end

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
  local btn1status = state.status == "start"
  local btn1txt = btn1status and "  Pause" or "  Start"

  local hovermark = vim.g.nvmark_hovered
  local btn1 = {
    btn1txt,
    hovermark == "tbtn1" and "ExRed" or "Normal",

    {
      hover = { id = "tbtn1", redraw = "actionbtns" },
      click = btn1status and api.pause or api.start,
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
