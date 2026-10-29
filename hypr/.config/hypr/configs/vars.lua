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
    launcher     = home .. "/.config/scripts/launcher",
    launcher_alt = home .. "/.config/scripts/launcher --list-executables-in-path",
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
