-- ########################################################### --
--                            RULES                            --
-- ########################################################### --

-- See https://wiki.hypr.land/configuring/core/rules/window-rules/

local rule = hl.window_rule


-- ==================== FLOATY WINDOWS ==================== --
rule({ name = "floaty-window", match = { title = "^(floaty_window)$" }, float = true })

rule({
    name      = "floaty-big",
    match     = { title = "^(floaty_big)$" },
    float     = true,
    size      = { 900, 600 },
    center    = true,
    animation = "popin",
})

rule({
    name      = "floaty-middle",
    match     = { title = "^(floaty_middle)$" },
    float     = true,
    size      = { 660, 486 },
    animation = "popin",
})

rule({ name = "floaty-small", match = { title = "^(floaty_small)$" }, float = true, size = { 325, 180 } })

-- Scratch terminal
rule({
    name      = "scratch-term",
    match     = { title = "^(scratch_term)$" },
    float     = true,
    size      = { 800, 500 },
    center    = true,
    animation = "popin",
})


-- ==================== SPOTIFY ==================== --
rule({
    name    = "spotify",
    match   = { class = "^(Spotify)$" },
    float   = true,
    size    = { 968, 600 },
    center  = true,
    opacity = "0.95 0.95",
})


-- ==================== FIREFOX ==================== --
rule({
    name  = "firefox-sharing",
    match = { class = "^(firefox)$", title = "^(Firefox — Sharing Indicator)$" },
    float = true,
})

rule({ name = "firefox-library", match = { title = "^(Library)$" }, float = true, center = true })


-- ==================== OPACITY PER APP ==================== --
local opacity = {
    { "zen-alpha",          "^(zen-alpha)$",     "0.97 0.97" },
    { "zen-beta",           "^(zen-beta)$",      "0.97 0.97" },
    { "firefox-opacity",    "^(firefox)$",       "0.97 0.97" },
    { "brave-opacity",      "^(Brave-browser)$", "0.95 0.95" },
    { "vscode-opacity",     "^(Code)$",          "0.97 0.97" },
    { "vscodium-opacity",   "^(vscodium)$",      "0.97 0.97" },
    { "kitty-opacity",      "^(kitty)$",         "0.96 0.96" },
    -- { "telegram",        "^(telegram)$",      "0.9 0.9" },
    { "neovide-opacity",    "^(neovide)$",       "0.95 0.95" },
    { "thunar-opacity",     "^(thunar)$",        "0.95 0.95" },
    { "nemo-opacity",       "^(nemo)$",          "0.95 0.95" },
    -- Discord & alternatives
    { "discord-opacity",    "^(discord)$",       "0.95 0.95" },
    { "webcord-opacity",    "^(WebCord)$",       "0.95 0.95" },
    { "vesktop-opacity",    "^(vesktop)$",       "0.95 0.95" },
    { "armcord-opacity",    "^(armcord)$",       "0.95 0.95" },
    -- GTK theme selectors
    { "qt5ct-opacity",      "^(qt5ct)$",         "0.95 0.95" },
    { "nwg-look-opacity",   "^(nwg-look)$",      "0.95 0.95" },
}

for _, o in ipairs(opacity) do
    rule({ name = o[1], match = { class = o[2] }, opacity = o[3] })
end


-- ==================== MPV ==================== --
rule({
    name         = "mpv",
    match        = { class = "^(mpv)$" },
    float        = true,
    size         = { 1280, 720 },
    center       = true,
    opacity      = "1.0 1.0",
    idle_inhibit = "focus",
})


-- ==================== IDLE INHIBIT ==================== --
rule({ name = "firefox-idle",   match = { class = "^(firefox)$" },       idle_inhibit = "fullscreen" })
rule({ name = "zen-alpha-idle", match = { class = "^(zen-alpha)$" },     idle_inhibit = "fullscreen" })
rule({ name = "brave-idle",     match = { class = "^(Brave-browser)$" }, idle_inhibit = "fullscreen" })


-- ==================== BLUETOOTH ==================== --
-- rule({ name = "blueman-float", match = { class = "^(blueman)$" }, float = true, opacity = "0.94 0.94" })
-- rule({ name = "blueman-mgr-float", match = { class = "^(blueman-manager)$" }, float = true })


-- ==================== WOFI ==================== --
rule({
    name         = "wofi",
    match        = { class = "^(wofi)$" },
    float        = true,
    stay_focused = true,
    opacity      = "0.85 0.85",
})


-- ==================== AMBEROL ==================== --
rule({ name = "amberol", match = { class = "^(amberol)$" }, float = true, size = { 670, 635 }, center = true })


-- ==================== GENERIC RULES ==================== --
-- Polkit
rule({
    name    = "polkit",
    match   = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" },
    float   = true,
    opacity = "0.90 0.80",
})

-- PulseAudio/PipeWire
rule({
    name    = "pavucontrol",
    match   = { class = "^(pavucontrol)$" },
    float   = true,
    size    = { 800, 600 },
    opacity = "0.90 0.80",
})

rule({ name = "lxappearance-float", match = { class = "^(Lxappearance)$" }, float = true })
rule({ name = "nemo-props-float",   match = { class = "^(nemo)$", title = "^(.*Properties)$" }, float = true })
rule({ name = "nemo-preview-float", match = { class = "^(Nemo-preview-start)$" }, float = true })
-- rule({ name = "rlr-float",       match = { class = "^(rlr)$" }, float = true })
-- rule({ name = "nm-conn-ed-float", match = { class = "^(nm-connection-editor)$" }, float = true })
-- rule({ name = "gparted-float",   match = { class = "^(GParted)$" }, float = true })
-- rule({ name = "qimgv-float",     match = { class = "^(qimgv)$" }, float = true, center = true })


-- ==================== BASIC WINDOWS ==================== --
-- File roller
rule({ name = "file-roller", match = { class = "^(file-roller)$" }, float = true, opacity = "0.95 0.95" })

-- Generic dialogs: { name, match, extra effects }
local dialogs = {
    { "media-viewer",     { title = "^(Media viewer)$" } },
    { "volume-control",   { title = "^(Volume Control)$" },            { size = { 640, 400 } } },
    { "pip",              { title = "^(Picture-in-Picture)$" } },
    { "devtools",         { title = "^(DevTools)$" } },
    { "mediainfo-gui",    { class = "^(mediainfo-gui)$" } },
    { "file-progress",    { class = "^(file_progress)$" } },
    { "confirm",          { class = "^(confirm)$" } },
    { "dialog",           { class = "^(dialog)$" } },
    { "download",         { class = "^(download)$" },                  { size = { 640, 400 } } },
    { "notification",     { class = "^(notification)$" } },
    { "error",            { class = "^(error)$" } },
    { "confirmreset",     { class = "^(confirmreset)$" } },
    { "open-file",        { title = "^(Open File)$" },                 { size = { 640, 400 } } },
    { "branchdialog",     { title = "^(branchdialog)$" } },
    { "confirm-replace",  { title = "^(Confirm to replace files)$" } },
    { "file-op-progress", { title = "^(File Operation Progress)$" } },
    { "viewnior",         { class = "^(Viewnior)$" } },
    -- { "feh-float",     { class = "^(feh)$" } },
    -- { "pavucontrol-qt", { class = "^(pavucontrol-qt)$" } },
}

for _, d in ipairs(dialogs) do
    local spec = { name = d[1], match = d[2], float = true }
    for k, val in pairs(d[3] or {}) do spec[k] = val end
    rule(spec)
end

-- Save dialog: sized but not floated (kept as in the original config)
rule({ name = "save-file", match = { title = "^(Save File)$" }, size = { 640, 400 } })


-- ==================== JETBRAINS / INTELLIJ ==================== --
-- Fix focus issues when dialogs are opened or closed
rule({
    name        = "jb-splash",
    match       = { class = "^(jetbrains-.*)$", title = "^(splash)$", float = true },
    center      = true,
    no_focus    = true,
    border_size = 0,
})

rule({
    name         = "jb-popups",
    match        = { class = "^(jetbrains-.*)$", title = "^( )$", float = true },
    center       = true,
    stay_focused = true,
    border_size  = 0,
})

rule({
    name        = "jb-autocomplete",
    match       = { class = "^(jetbrains-.*)$", title = "^(win.*)$", float = true },
    no_focus    = true,
    border_size = 0,
})

rule({ name = "jb-idea-center", match = { class = "^(jetbrains-idea)$" }, center = true })


-- ==================== LIBRETRO / RETROARCH ==================== --
rule({
    name        = "libretro-noborder",
    match       = { class = "^(libretro.*)$", title = "^( )$", fullscreen = true },
    border_size = 0,
})

rule({
    name        = "retroarch-noborder",
    match       = { class = "^(org.libretro.RetroArch)$", title = "^( )$", fullscreen = true },
    border_size = 0,
})


-- ==================== LAYER RULES ==================== --
-- See https://wiki.hypr.land/configuring/core/rules/layer-rules/
for _, ns in ipairs({ "waybar", "gtk-layer-shell", "notifications", "launcher", "logout_dialog" }) do
    hl.layer_rule({ name = "blur-" .. ns, match = { namespace = "^" .. ns .. "$" }, blur = true, ignore_alpha = 0 })
end


-- ==================== PERFORMANCE RULES ==================== --
rule({ name = "steam-noblur",     match = { class = "^(steam)$" },     no_blur = true })
rule({ name = "gamescope-noblur", match = { class = "^(gamescope)$" }, no_blur = true })
