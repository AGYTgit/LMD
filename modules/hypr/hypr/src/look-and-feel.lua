hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		col = {
			active_border = {
				colors = { "rgba(33ccffee)", "rgba(aa1199ee)" },
				angle = 35,
			},
			inactive_border = "rgba(595959aa)",
		},
		-- layout = "scrolling",
		layout = "master",
		allow_tearing = true,
	},

	decoration = {
		rounding = 8,
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},

		screen_shader = "/home/emi/.dotfiles/LMD/modules/hyprshade/hyprshade/shaders/vib.glsl",
	},

    master = {
        mfact = 0.50,
    },

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
	},

	cursor = {
		inactive_timeout = 1,
		no_hardware_cursors = 0,
	},
})

hl.config({
	animations = {
		enabled = false,
	},
})

-- for scrolling layout
-- -- Curves (Beziers)
-- hl.curve("default", { type = "bezier", points = { { 1, 1 }, { 0, 0 } } })
--
-- -- Animations
-- hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "default" })
-- hl.animation({ leaf = "windowsIn", enabled = true, speed = 2, bezier = "default", style = "slide right" })
-- hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "default", style = "slide right" })
-- hl.animation({ leaf = "windowsMove", enabled = true, speed = 2, bezier = "default", style = "slide right" })
-- hl.animation({ leaf = "fade", enabled = false })
--
-- hl.animation({ leaf = "workspaces", enabled = false })
