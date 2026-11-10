-- ########################################################### --
--                          GAME MODE                          --
-- ########################################################### --

-- Toggled by ~/.scripts/hyprland_toggle_gamemode through a flag file,
-- so this file never changes on disk. Must be loaded last.
-- Strips every compositor effect so the GPU (shared iGPU) goes to the game.

local flag = io.open("/tmp/hypr_gamemode", "r")
if not flag then return end
flag:close()

hl.config({
    animations = { enabled = false },
    decoration = {
        rounding           = 0,
        active_opacity     = 1.0,
        inactive_opacity   = 1.0,
        fullscreen_opacity = 1.0,
        dim_inactive       = false,
        blur               = { enabled = false },
        shadow             = { enabled = false },
    },
})

hl.window_rule({ name = "gamemode-opacity", match = { class = ".*" }, opacity = "1.0 1.0" })
