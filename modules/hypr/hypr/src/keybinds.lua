require("src.vars")

local mainMod = "SUPER"

-- Basic Application & Window Binds
-- hl.bind("ALT + BACKSPACE", hl.dsp.exec_cmd(vars.terminal))
hl.bind("ALT + BACKSPACE", hl.dsp.exec_cmd("alacritty"))
-- hl.bind("ALT + SPACE", hl.dsp.exec_cmd(vars.menu))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("wofi"))
hl.bind("ALT + Q", hl.dsp.window.close())
hl.bind("ALT + W", hl.dsp.window.fullscreen())
-- hl.bind("ALT + V", hl.dsp.window.toggle_floating())

hl.bind(mainMod .. " + M", hl.dsp.exit())
-- hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(vars.file_manager))

-- Resize Windows
hl.bind("ALT + CONTROL + H", hl.dsp.window.resize({ x = -50, y = 0 }))
hl.bind("ALT + CONTROL + J", hl.dsp.window.resize({ x = 0, y = 50 }))
hl.bind("ALT + CONTROL + K", hl.dsp.window.resize({ x = 0, y = -50 }))
hl.bind("ALT + CONTROL + L", hl.dsp.window.resize({ x = 50, y = 0 }))

-- Swap Windows
hl.bind("ALT + SHIFT + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind("ALT + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))
hl.bind("ALT + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind("ALT + SHIFT + L", hl.dsp.window.swap({ direction = "r" }))

-- Layout
-- hl.bind("ALT + M", hl.dispatch("layoutmsg", "orientationnext"))

-- Toggle Layout
hl.bind("ALT + CONTROL + 0", hl.dsp.exec_cmd("/usr/bin/hyprctl switchxkblayout all 0"))
hl.bind("ALT + CONTROL + 9", hl.dsp.exec_cmd("/usr/bin/hyprctl switchxkblayout all 1"))

-- Brightness Controls
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))

-- Audio Switches
hl.bind(
	"ALT + XF86Tools",
	hl.dsp.exec_cmd(
		"sed -i 's/^1$/TEMP/; s/^0$/1/; s/^TEMP$/0/' $HOME/.dotfiles/LMD/modules/audio-manager/config/sink-mute"
	)
)
hl.bind(
	"XF86Tools",
	hl.dsp.exec_cmd(
		"sed -i 's/^1$/TEMP/; s/^0$/1/; s/^TEMP$/0/' $HOME/.dotfiles/LMD/modules/audio-manager/config/source-mute"
	)
)

-- Laptop Lid Switch (bindl flag corresponds to locked = true)
hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })

-- Focus Movement
hl.bind("ALT + H", hl.dsp.focus({ direction = "l" }))
hl.bind("ALT + L", hl.dsp.focus({ direction = "r" }))
hl.bind("ALT + K", hl.dsp.focus({ direction = "u" }))
hl.bind("ALT + J", hl.dsp.focus({ direction = "d" }))

-- Hyprshot & Hyprpicker Screen Utilities
hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.exec_cmd("shader=$(hyprshade current); hyprshade off; hyprshot -m region --clipboard-only; hyprshade on vib")
)
hl.bind(
	mainMod .. " + SHIFT + C",
	hl.dsp.exec_cmd("shader=$(hyprshade current); hyprshade off; hyprpicker -af hex; hyprshade on vib")
)

--------------------------------------------------------------------------------
--- Mouse Binds (bindm -> mouse = true flag)
--------------------------------------------------------------------------------
hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------------------------------------------------------------------------
--- Workspaces
--------------------------------------------------------------------------------
-- Switch workspace
hl.bind("ALT + 5", hl.dsp.focus({ workspace = "1" }))
hl.bind("ALT + 4", hl.dsp.focus({ workspace = "2" }))
hl.bind("ALT + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("ALT + 2", hl.dsp.focus({ workspace = "4" }))
hl.bind("ALT + 1", hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = "9" }))
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = "10" }))

-- Move window to workspace
hl.bind("ALT + SHIFT + 5", hl.dsp.window.move({ workspace = "1" }))
hl.bind("ALT + SHIFT + 4", hl.dsp.window.move({ workspace = "2" }))
hl.bind("ALT + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("ALT + SHIFT + 2", hl.dsp.window.move({ workspace = "4" }))
hl.bind("ALT + SHIFT + 1", hl.dsp.window.move({ workspace = "5" }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "6" }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "7" }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "8" }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "9" }))
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "10" }))

-- Special Workspaces
hl.bind("ALT + Y", function()
	if hl.dsp.exec_cmd("pgrep -x ncmpcpp") == "" then
        hl.dispatch(hl.dsp.workspace.toggle_special("ncmpcpp"))
        hl.dispatch(hl.dsp.exec_cmd("alacritty -e ncmpcpp"))
        return
    end

    hl.dispatch(hl.dsp.workspace.toggle_special("ncmpcpp"))
end)

hl.bind("ALT + P", function()
	if hl.dsp.exec_cmd("pgrep -x qalculate-gtk") == "" then
        hl.dispatch(hl.dsp.exec_cmd("qalculate-gtk"))
        return
    end

    hl.dispatch(hl.dsp.workspace.toggle_special("qalculate-gtk"))
end)
