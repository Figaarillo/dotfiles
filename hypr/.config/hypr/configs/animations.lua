-- ########################################################### --
--                          ANIMATIONS                         --
-- ########################################################### --

-- See https://wiki.hypr.land/configuring/core/animations/
-- iOS 26 feel: things "pop" in on an underdamped spring (a hint of bounce),
-- move on a critically-damped one (no bounce), and leave fast without bouncing.
-- Damping ratio = damping / (2 * sqrt(mass * stiffness)): <1 bounces, ~1 doesn't.

hl.config({ animations = { enabled = true } })

-- ####################### SPRINGS ######################## --
hl.curve("liquid", { type = "spring", mass = 1, stiffness = 260, damping = 24 }) -- ratio ~0.74: soft bounce
hl.curve("glide",  { type = "spring", mass = 1, stiffness = 220, damping = 28 }) -- ratio ~0.94: settles, no bounce

-- ####################### BEZIERS ######################## --
hl.curve("dismiss", { type = "bezier", points = { {0.4, 0},  {1, 1}    } }) -- accelerate out
hl.curve("smooth",  { type = "bezier", points = { {0.23, 1}, {0.32, 1} } }) -- easeOutQuint
hl.curve("liner",   { type = "bezier", points = { {1, 1},    {1, 1}    } })

-- ####################### WINDOWS ######################## --
hl.animation({ leaf = "windows",     enabled = true,  speed = 5,   spring = "glide" })
hl.animation({ leaf = "windowsIn",   enabled = true,  speed = 4.5, spring = "liquid",  style = "popin 85%" })
hl.animation({ leaf = "windowsOut",  enabled = true,  speed = 1.8, bezier = "dismiss", style = "popin 90%" })
hl.animation({ leaf = "windowsMove", enabled = true,  speed = 5,   spring = "glide" })

-- ######################## LAYERS ######################## --
-- fuzzel, wlogout, waybar on restart: pop in like an iOS sheet
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,   spring = "liquid",  style = "popin 90%" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5, bezier = "dismiss", style = "popin 95%" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 2.5, bezier = "smooth" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.5, bezier = "dismiss" })

-- ######################### FADES ######################## --
hl.animation({ leaf = "fadeIn",  enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "dismiss" })
hl.animation({ leaf = "fade",    enabled = true, speed = 3, bezier = "smooth" })

-- ######################## BORDERS ####################### --
hl.animation({ leaf = "border",      enabled = true,  speed = 5,  bezier = "smooth" })
hl.animation({ leaf = "borderangle", enabled = false, speed = 30, bezier = "liner", style = "loop" })

-- ###################### WORKSPACES ###################### --
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, spring = "glide", style = "slidefade 20%" })
