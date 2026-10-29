-- ########################################################### --
--                   HYPRLAND CONFIGURATION                    --
-- ########################################################### --

-- See https://wiki.hypr.land/configuring/

local v = require("configs.vars")


-- ######################## AUTOSTART ######################## --
hl.on("hyprland.start", function()
    hl.exec_cmd(v.config .. "/autostart")
end)


-- ######################### ENV VARS ######################## --
require("configs.env")


-- ###################### MONITOR CONFIG ##################### --
require("configs.monitor")


-- ######################### GENERAL ######################### --
hl.config({
    general = {
        gaps_in     = 5,
        gaps_out    = 10,
        border_size = 2,
        col = {
            -- Liquid Glass edge: a light specular rim fading into the accent
            active_border         = { colors = { "rgba(ffffff59)", "rgba(cba6f740)" }, angle = 135 },
            inactive_border       = "rgba(ffffff14)",
            nogroup_border        = "rgba(89dcebff)",
            nogroup_border_active = "rgba(f9e2afff)",
        },
        resize_on_border = true,
        layout           = "dwindle", -- master | dwindle
    },

    cursor = {
        inactive_timeout = 5,
    },
})


-- ########################## INPUT ########################## --
hl.config({
    input = {
        kb_layout          = "us,us",
        kb_variant         = "basic,intl",
        kb_options         = "grp:alt_space_toggle",
        numlock_by_default = true,

        sensitivity = 0.5,

        follow_mouse                = 1,
        float_switch_override_focus = 0,

        scroll_method = "2fg",
        accel_profile = "flat",

        touchpad = {
            tap_to_click         = true, -- one-finger tap = left click
            natural_scroll       = true,
            disable_while_typing = true,
            scroll_factor        = 0.5,  -- lower for slower scrolling
        },

        touchdevice = {
            transform = 2,
            enabled   = false,
        },
    },
})


-- ######################### LAYOUT ########################## --
hl.config({
    dwindle = {
        force_split    = 0,
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },
})


-- ######################## GESTURES ######################### --
-- Workspace swipe is not enabled; to enable it add:
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.config({
    gestures = {
        workspace_swipe_distance           = 250,
        workspace_swipe_min_speed_to_force = 5,
        workspace_swipe_cancel_ratio       = 0.2,
        workspace_swipe_create_new         = true,
        workspace_swipe_forever            = true,
    },
})


-- ########################## MISC ########################### --
hl.config({
    misc = {
        disable_hyprland_logo      = true,
        disable_splash_rendering   = true,
        mouse_move_enables_dpms    = true,
        focus_on_activate          = true,
        animate_manual_resizes     = false,
        mouse_move_focuses_monitor = true,
        enable_swallow             = true,
        swallow_regex              = "^(kitty)$",
    },
})


-- ####################### DECORATIONS ####################### --
require("configs.decorations")


-- ######################## ANIMATIONS ####################### --
require("configs.animations")


-- ####################### KEYBINDINGS ####################### --
require("configs.keybindings")


-- ########################## RULES ########################## --
require("configs.rules")


-- ####################### CLEAN MODE ######################## --
-- Must stay last so it overrides decorations and rules
require("configs.cleanmode")
