-- ########################################################### --
--                         DECORATIONS                         --
-- ########################################################### --

-- See https://wiki.hypr.land/configuring/core/config-options/

hl.config({
    decoration = {
        -- ############### ROUNDING OF THE CORNERS ############### --
        rounding = 16, -- iOS-like large corners

        -- ####################### SHADOWS ####################### --
        shadow = {
            enabled      = false,
            range        = 50,
            render_power = 2,
            offset       = "0 2",
            scale        = 0.97,
            color        = "rgba(1a1a1aee)",
        },

        -- ######################## DIMING ####################### --
        dim_inactive = false,
        dim_strength = 0.03,

        -- ####################### OPACITY ####################### --
        active_opacity     = 0.97,
        inactive_opacity   = 0.95,
        fullscreen_opacity = 1.0,

        -- ##################### BLURRING ######################## --
        blur = {
            -- Blur "amount" is size * passes; high size (over ~5) produces artifacts.
            -- For heavy blur, raise passes instead.
            enabled           = true,
            size              = 4,
            passes            = 2,    -- more passes = more resources
            ignore_opacity    = true, -- blur layer ignores the window opacity
            new_optimizations = true,
            xray              = true, -- floating windows ignore tiled windows in their blur

            noise             = 0,    -- no noise (saves computation)
            contrast          = 1.0,
            brightness        = 1.0,
            vibrancy          = 0.18, -- Liquid Glass: saturate what's behind (cheap, no extra passes)
            vibrancy_darkness = 0.0,

            special           = false,
        },
    },
})
