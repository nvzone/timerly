local M = {}
local api = require("timerly.api")
local state = require("timerly.state")
local voltui = require("volt.ui")

M.modes = function()
	local hovermark = vim.g.nvmark_hovered
	local mode = state.mode

	local focus_m = {
		"   Focus ",
		((mode == "focus" or hovermark == "focus_m") and "exgreen") or "commentfg",
		{
			hover = { id = "focus_m", redraw = "modes" },
			click = api.togglemode,
		},
	}

	local break_m = {
		" 󰒲  Break",
		((mode == "break" or hovermark == "break_m") and "exgreen") or "commentfg",
		{

			hover = { id = "break_m", redraw = "modes" },
			click = api.togglemode,
		},
	}

	return {
		{ { "│ ", "commentfg" }, { "󰀘  Modes     " }, focus_m, break_m, { " │", "commentfg" } },
	}
end

M.clock = function()
	return state.clock
end

M.progress = function()
	local lines = voltui.progressbar({
		w = state.w_with_pad,
		val = state.progress,
		icon = { on = "|", off = "|" },
	})

	return { lines }
end

M.actionbtns = function()
	local hovermark = vim.g.nvmark_hovered

	local btn1 = {
		state.status == "start" and "  Pause" or "  Start",
		hovermark == "tbtn1" and "ExRed" or "Normal",

		{
			hover = { id = "tbtn1", redraw = "actionbtns" },
			click = api.togglestatus,
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
