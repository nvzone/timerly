local ui = require "timerly.ui"
local state = require "timerly.state"

local function ypad(n)
  local emptylines = {}

  for _ = 1, n do
    table.insert(emptylines, {})
  end

  return {
    lines = function()
      return emptylines
    end,

    name = "ypad",
  }
end

local line = function(id, direction)
  local icon = direction == "up" and { "┌", "┐" } or { "└", "┘" }

  return {
    col_start =2,
    lines = function()
      return {
        { { icon[1] .. string.rep("─", state.w_with_pad ) .. icon[2], "comment" } },
      }
    end,
    name = id,
  }
end

return {

  line("line1", "up"),

  {
    lines = ui.modes,
    name = "modes",
    col_start=2
  },

  line "line2",

  ypad(1),

  {
    lines = ui.clock,
    name = "clock",
  },

  ypad(2),

  {
    lines = ui.progress,
    name = "progress",
  },
  ypad(1),

  {
    lines = ui.actionbtns,
    name = "actionbtns",
  },
}
