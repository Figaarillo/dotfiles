-- ########################################################### --
--                         KEYBINDINGS                         --
-- ########################################################### --

-- See https://wiki.hypr.land/configuring/core/binds/

local v       = require("configs.vars")
local dsp     = hl.dsp
local exec    = dsp.exec_cmd
local scripts = v.scripts
local bind    = hl.bind

hl.config({ binds = { allow_workspace_cycles = true } })


-- ###################### MOUSE BINDS ###################### --
bind("SUPER + mouse:272", dsp.window.drag(),   { mouse = true }) -- left click
bind("SUPER + mouse:273", dsp.window.resize(), { mouse = true }) -- right click
bind("SUPER + mouse_down", dsp.focus({ workspace = "e-1" }))
bind("SUPER + mouse_up",   dsp.focus({ workspace = "e+1" }))


-- ###################### KITTY BINDS ###################### --
bind("SUPER + RETURN",       exec(v.term))
bind("SUPER + T",            exec("kitty --title floaty_big --single-instance"))
bind("SUPER + ALT + RETURN", exec("kitty --start-as=fullscreen --title floaty_window -o font_size=15"))


-- #################### CYCLE WALLPAPER #################### --
bind("SUPER + bracketleft",  exec(scripts .. "/tools/expand cycler"))
bind("SUPER + bracketright", exec(scripts .. "/tools/expand cycle"))


-- ################ TOGGLE PLAY/PAUSE PLAYER ############### --
bind("SUPER + SHIFT + p",            exec("playerctl play-pause"))
bind("SUPER + SHIFT + bracketleft",  exec("playerctl previous"))
bind("SUPER + SHIFT + bracketright", exec("playerctl next"))


-- ################### SCREENSHOT BINDS #################### --
bind("SUPER + SHIFT + S", exec(scripts .. "/screenshot"))
bind("Print",             exec(scripts .. "/screenshot_full"))


-- ###################### EMOJI BINDS ###################### --
bind("SUPER + period", exec(scripts .. "/emoji.sh"))


-- ###################### COLOR PICKER ##################### --
bind("SUPER + SHIFT + C", exec(scripts .. "/color-picker"))


-- ################### APPLICATION BINDS ################### --
bind("SUPER + Q",         dsp.window.close())
bind("SUPER + F",         exec(v.explorer))
bind("SUPER + SHIFT + F", exec(v.explorer2))
bind("SUPER + W",         exec(v.browser))
bind("SUPER + SHIFT + W", exec(v.browser2))
bind("SUPER + G",         exec(v.gmail))
bind("SUPER + E",         exec(v.editor))
bind("SUPER + SHIFT + E", exec(v.notepad))
bind("SUPER + M",         exec(v.music))
bind("SUPER + D",         exec(v.discord))
bind("SUPER + B",         exec(v.bluetooth))
bind("SUPER + O",         exec(v.office))
bind("SUPER + SHIFT + O", exec("obsidian"))


-- ############## WOFI AND NOTIFICATION BINDS ############## --
bind("SUPER + V",     exec("pkill wofi || cliphist list | wofi --dmenu -p clippick -l top_right -x -15 -y 10 -n | cliphist decode | wl-copy"))
bind("SUPER + N",     exec("swaync-client -t -sw"))
-- Tap SUPER alone to open the launcher
bind("Super_L",       exec("pkill fuzzel || " .. v.launcher), { release = true })
bind("SUPER + space", exec("pkill fuzzel || " .. v.launcher_alt))


-- ################### OTHER DISPATCHERS ################### --
bind("ALT + Tab",        dsp.window.cycle_next())
bind("SUPER + ALT + M",  dsp.window.fullscreen())
bind("SUPER + ALT + C",  dsp.window.center())
bind("SUPER + P",        dsp.window.pseudo())
bind("SUPER + S",        dsp.window.float({ action = "toggle" }))
-- bind("SUPER + A",     dsp.layout("togglesplit"))
bind("SUPER + Z",        exec("~/.scripts/hyprland_toggle_animations"))
bind("SUPER + ALT + Z",  exec("~/.scripts/hyprland_toggle_opacity"))
bind("CTRL + ALT + Delete", dsp.exit())


-- ###################### GROUP BINDS ###################### --
bind("SUPER + SHIFT + G", dsp.group.toggle())
bind("SUPER + CTRL + tab", dsp.group.next())


-- ##################### RELOAD WAYBAR ##################### --
bind("SUPER + SHIFT + R", exec(scripts .. "/launch_waybar"))
bind("SUPER + ALT + R",   exec("killall -SIGUSR1 waybar")) -- Hide waybar


-- ############### LOGOUT SCREEN, LOCK, EXIT ############### --
bind("SUPER + escape",         exec("~/.config/wlogout/launch.sh"))
bind("SUPER + ALT + L",        exec(scripts .. "/lock"))
bind("SUPER + SHIFT + escape", exec("playerctl --all-players stop; awww quit; hyprctl dispatch 'hl.dsp.exit()'"))


-- ################## WINDOW MANIPULATION ################## --
local directions = {
    { vim = "h", arrow = "left",  dir = "left",  resize = { x = -20, y = 0 } },
    { vim = "l", arrow = "right", dir = "right", resize = { x = 20,  y = 0 } },
    { vim = "k", arrow = "up",    dir = "up",    resize = { x = 0,   y = -20 } },
    { vim = "j", arrow = "down",  dir = "down",  resize = { x = 0,   y = 20 } },
}

for _, d in ipairs(directions) do
    for _, key in ipairs({ d.vim, d.arrow }) do
        -- Move focus
        bind("SUPER + " .. key,         dsp.focus({ direction = d.dir }))
        -- Move window
        bind("SUPER + SHIFT + " .. key, dsp.window.move({ direction = d.dir }))
        -- Resize window
        bind("SUPER + CTRL + " .. key,  dsp.window.resize({ x = d.resize.x, y = d.resize.y, relative = true }))
    end
end


-- #################### WORKSPACE BINDS #################### --
bind("SUPER + TAB",         dsp.focus({ workspace = "e+1" }))
bind("SUPER + SHIFT + TAB", dsp.focus({ workspace = "e-1" }))

for i = 1, 9 do
    -- Move to a workspace
    bind("SUPER + " .. i,         exec(scripts .. "/hyprland_move_ws " .. i))
    -- Move windows between workspaces
    bind("SUPER + SHIFT + " .. i, dsp.window.move({ workspace = i }))
end


-- ######################## RICING ######################### --
bind("CTRL + 1", exec("kitty --title floaty_middle sh -c 'cava'"))
bind("CTRL + 2", exec("kitty --title floaty_middle sh -c '~/.cargo/bin/rusty-rain -C 0,139,139 -s -c jap'"))
bind("CTRL + 3", exec("kitty --title floaty_small sh -c 'tty-clock -C5 -c'"))
bind("CTRL + 4", exec("kitty --title floaty_middle sh -c 'cbonsai -li'"))
bind("CTRL + 5", exec("kitty --title floaty_middle sh -c '~/.cargo/bin/pipes-rs'"))


-- ###################### MEDIA KEYS ####################### --
-- Use `wev` to find the XF86 name of a key

-- Volume Control
bind("XF86AudioRaiseVolume", exec("pactl set-sink-volume @DEFAULT_SINK@ +5%"),     { repeating = true })
bind("XF86AudioLowerVolume", exec("pactl set-sink-volume @DEFAULT_SINK@ -5%"),     { repeating = true })
bind("XF86AudioMute",        exec("pactl set-sink-mute @DEFAULT_SINK@ toggle"),    { repeating = true })
bind("XF86AudioMicMute",     exec("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { repeating = true })

-- Media Control
bind("XF86AudioMedia", exec("playerctl play-pause"), { repeating = true })
bind("XF86AudioPlay",  exec("playerctl play-pause"), { repeating = true })
bind("XF86AudioStop",  exec("playerctl stop"),       { repeating = true })
bind("XF86AudioPrev",  exec("playerctl previous"),   { repeating = true })
bind("XF86AudioNext",  exec("playerctl next"),       { repeating = true })

-- Brightness Control
bind("XF86MonBrightnessUp",   exec("brightnessctl set 5%+"), { repeating = true })
bind("XF86MonBrightnessDown", exec("brightnessctl set 5%-"), { repeating = true })

-- Screensaver key
bind("XF86ScreenSaver", exec("~/.scripts/lock"), { locked = true })

-- Power Management
bind("XF86PowerOff", exec("~/.scripts/lock"))

-- Others
bind("XF86Mail",       exec(v.gmail))
bind("XF86HomePage",   exec(v.explorer .. " ~/"))
bind("XF86Calculator", exec("qalculate-gtk"))
bind("XF86Search",     exec("wofi"))


-- ######################## SWITCHES ####################### --
-- bind("switch:on:Lid Switch", exec("hyprctl keyword monitor ', 1920x1080@60, auto, 1'"), { locked = true })
bind("switch:off:Lid Switch", exec("playerctl --all-players stop; ~/.scripts/lock; sleep 0.25s; systemctl suspend"), { locked = true })
