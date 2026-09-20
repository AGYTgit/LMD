local vars = require("src.vars")

-- terminal/app launcher
hl.bind("ALT + BACKSPACE", hl.dsp.exec_cmd(vars.terminal))
hl.bind("ALT + SEMICOLON", hl.dsp.exec_cmd(vars.terminal))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(vars.menu))
hl.bind("ALT + I", hl.dsp.exec_cmd(vars.menu))

-- fun
hl.bind("ALT + Q", hl.dsp.window.close())
hl.bind("ALT + V", hl.dsp.window.float())
hl.bind("ALT + W", hl.dsp.window.fullscreen())

-- cycle layout
hl.bind("ALT + SHIFT + A", hl.dsp.exec_cmd("hyprctl switchxkblayout current next"))

-- logout
hl.bind("SUPER + M", hl.dsp.exit())

-- Hyprshot & Hyprpicker
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("hyprshade off; hyprshot -m region --clipboard-only; hyprctl reload"))
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprshade off;  hyprpicker -af hex; hyprctl reload"))

-- clicker
-- hl.bind("SHIFT + mouse:276", hl.dsp.exec_cmd("/home/emi/.dotfiles/LMD/modules/hypr/hypr/src/keybinds/clicker.sh start"))
-- hl.bind("SHIFT + mouse:276", hl.dsp.exec_cmd("/home/emi/.dotfiles/LMD/modules/hypr/hypr/src/keybinds/clicker.sh stop"), { release = true })
-- hl.bind("mouse:276", hl.dsp.exec_cmd("/home/emi/.dotfiles/LMD/modules/hypr/hypr/src/keybinds/clicker.sh stop"), { release = true })

-- hyprlock on lid close  NOTE: laptop only
-- hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("hyprlock"), { locked = true })

-- brightness  NOTE: laptop only
-- hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"))
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"))
