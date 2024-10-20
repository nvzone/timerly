vim.api.nvim_create_user_command("TimerlyToggle", function()
	require("timerly").toggle()
end, { desc = "Toggle Timerly" })
