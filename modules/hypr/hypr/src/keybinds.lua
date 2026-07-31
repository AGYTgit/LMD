local vars = require("src.vars")

local mainMod = "ALT"
local otherMod = "SUPER"

-- Basic Application & Window Binds
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd(vars.terminal))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(vars.menu))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + W", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V", hl.dsp.window.float())

hl.bind(otherMod .. " + M", hl.dsp.exit())

-- Resize Windows
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })

-- Swap Windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))

-- Brightness Controls  NOTE: laptop only
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))

-- Audio Switches  TODO: needs rework
-- hl.bind(
-- 	mainMod .. " + XF86Tools",
-- 	hl.dsp.exec_cmd(
-- 		"sed -i 's/^1$/TEMP/; s/^0$/1/; s/^TEMP$/0/' $HOME/.dotfiles/LMD/modules/audio-manager/config/sink-mute"
-- 	)
-- )
-- hl.bind(
-- 	"XF86Tools",
-- 	hl.dsp.exec_cmd(
-- 		"sed -i 's/^1$/TEMP/; s/^0$/1/; s/^TEMP$/0/' $HOME/.dotfiles/LMD/modules/audio-manager/config/source-mute"
-- 	)
-- )

-- lock on lid close  NOTE: laptop only
-- hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })

-- Focus Movement
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + T", hl.dsp.layout("orientationcycle center left")) -- master

-- Hyprshot & Hyprpicker
hl.bind( -- TODO: needs uptade to use new shader manipulation
	otherMod .. " + SHIFT + S",
	hl.dsp.exec_cmd("shader=$(hyprshade current); hyprshade off; hyprshot -m region --clipboard-only; hyprshade on vib")
)
hl.bind(
	otherMod .. " + SHIFT + C",
	hl.dsp.exec_cmd("shader=$(hyprshade current); hyprshade off; hyprpicker -af hex; hyprshade on vib")
)

-- mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Switch workspace
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = "5" }))
hl.bind(otherMod .. " + 5", hl.dsp.focus({ workspace = "6" }))
hl.bind(otherMod .. " + 4", hl.dsp.focus({ workspace = "7" }))
hl.bind(otherMod .. " + 3", hl.dsp.focus({ workspace = "8" }))
hl.bind(otherMod .. " + 2", hl.dsp.focus({ workspace = "9" }))
hl.bind(otherMod .. " + 1", hl.dsp.focus({ workspace = "10" }))

-- Move window to workspace
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "1" }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "2" }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "4" }))
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "5" }))
hl.bind(otherMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "6" }))
hl.bind(otherMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "7" }))
hl.bind(otherMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "8" }))
hl.bind(otherMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "9" }))
hl.bind(otherMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "10" }))

-- Special Workspaces
hl.bind(mainMod .. " + Y", function()
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

hl.bind(mainMod .. " + P", function()
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
