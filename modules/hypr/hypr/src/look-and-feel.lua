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
        layout = "dwindle",
        allow_tearing = true,
    },

    decoration = {
        rounding = 5,
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        -- shadow = {
        --     enabled = true,
        --     range = 4,
        --     render_power = 3,
        --     color = "rgba(1a1a1aee)",
        -- },

        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
        },

        screen_shader = '/home/emi/.dotfiles/LMD/modules/hyprshade/hyprshade/shaders/vib.glsl';
    },

    dwindle = {
        preserve_split = true,
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
