-- ########################################################### --
--                           MONITORS                          --
-- ########################################################### --

-- See https://wiki.hypr.land/configuring/core/monitors/

-- Fallback: any new monitor at auto position
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
-- hl.monitor({ output = "", disabled = true })
hl.monitor({ output = "HDMI-A0", mode = "preferred", position = "-1920x0", scale = 1 })
