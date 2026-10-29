-- ########################################################### --
--                          CLEAN MODE                         --
-- ########################################################### --

-- Toggled by ~/.scripts/hyprland_toggle_opacity through a flag file,
-- so this file never changes on disk. Must be loaded last.

local flag = io.open("/tmp/hypr_cleanmode", "r")
if not flag then return end
flag:close()

hl.config({
    decoration = {
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        blur             = { enabled = false },
        dim_inactive     = false,
    },
})

hl.window_rule({ name = "cleanmode-opacity", match = { class = ".*" }, opacity = "1.0 1.0" })
