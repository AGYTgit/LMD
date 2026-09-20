hl.bind("ALT + Y", function()
	local handle = io.popen("pgrep -x ncmpcpp")
	if handle == nil then
		return
	end
	local result = handle:read("*a")
	handle:close()

	if result == "" then
		hl.dispatch(hl.dsp.workspace.toggle_special("ncmpcpp"))
		hl.dispatch(hl.dsp.exec_cmd("alacritty -e ncmpcpp"))
		return
	end

	hl.dispatch(hl.dsp.workspace.toggle_special("ncmpcpp"))
end)

hl.bind("ALT + P", function()
	local handle = io.popen("pgrep -x qalculate-gtk")
	if handle == nil then
		return
	end
	local result = handle:read("*a")
	handle:close()

	if result == "" then
		hl.dispatch(hl.dsp.exec_cmd("qalculate-gtk"))
		return
	end

	hl.dispatch(hl.dsp.workspace.toggle_special("qalculate-gtk"))
end)
