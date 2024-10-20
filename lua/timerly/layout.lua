local ui = require "timerly.ui"

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

return {

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
