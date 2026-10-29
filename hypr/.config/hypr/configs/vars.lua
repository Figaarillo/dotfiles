-- ########################################################### --
--                          VARIABLES                          --
-- ########################################################### --

local home = os.getenv("HOME")

return {
    bluetooth    = "blueman-manager",
    browser      = "zen-browser",
    browser2     = "brave",
    discord      = "discord",
    explorer     = "nemo",
    explorer2    = "nautilus",
    gmail        = "geary",
    launcher     = "wofi --show drun -n",
    launcher_alt = "wofi --show run -n",
    music        = "spotify",
    notepad      = "geany",
    office       = "onlyoffice",
    term         = "kitty",
    editor       = "vscodium",
    -- notepad   = "code --profile notepad --unity-launch ~/Templates",

    home         = home,
    scripts      = home .. "/.config/scripts",
    config       = home .. "/.config/hypr/configs",
}
