hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- NVIDIA
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.env("XDPH_WLR_SCREENCOPY_FORMAT", "shm")

hl.env("__GL_SHADER_DISK_CACHE", "1")
hl.env("__GL_SHADER_DISK_CACHE_SKIP_CLEANUP", "1")
hl.env("__GL_SHADER_DISK_CACHE_SIZE", "21474836480")

-- Toolkit Backend
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

-- Turn off FPS cap (commented out)
-- hl.env("__GL_SYNC_TO_VBLANK", "0")

-- GTK / Qt Theme Settings
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- Hyprcursor
hl.env("HYPRCURSOR_THEME", "cross-theme")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

-- Japanese Fcitx Environment
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("INPUT_METHOD", "fcitx")

-- Discord force Wayland
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "YOUR_DARK_GTK3_THEME"')
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
