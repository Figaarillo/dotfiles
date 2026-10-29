-- ########################################################### --
--                    ENVIRONMENT VARIABLES                    --
-- ########################################################### --

-- See https://wiki.hypr.land/configuring/core/environment-variables/


-- ################ TOOLKIT BACKEND VARIABLES ################ --
hl.env("GDK_BACKEND", "wayland")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")


-- #################### XDG SPECIFICATIONS ################### --
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")


-- ####################### QT VARIABLES ###################### --
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
-- hl.env("QT_STYLE_OVERRIDE", "kvantum")


-- #################### THEMING VARIABLES #################### --
-- hl.env("GTK_THEME", "")
hl.env("XCURSOR_THEME", "Layan-cursors")
hl.env("XCURSOR_SIZE", "24")


-- ################### GENERAL VARIABLES #################### --
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("EGL_PLATFORM", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")

hl.env("OZONE_PLATFORM", "wayland")
