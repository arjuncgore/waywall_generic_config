-- ======== WAYWALL GENERIC CONFIG ========

-- ==== LOOKS ====
local bg_col = "#000000"
local toggle_bg_picture = false
local primary_col = "#ec6e4e"
local secondary_col = "#E446C4"

local ninbot_anchor = "topright" -- topleft, top, topright, left, right, bottomleft, bottomright
local ninbot_opacity = 1         -- 0 to 1


-- ==== MIRRORS ====
local e_count = { enabled = true, x = 1340, y = 300, size = 5, colorkey = false }
local thin_pie = { enabled = true, x = 1250, y = 500, size = 4, colorkey = false } -- Turning off colorkeying also maintains the original pie chart's dimensions and shows the percentages
local thin_percent = { enabled = false, x = 1300, y = 850, size = 6 }
local tall_pie = { enabled = true, x = 1250, y = 500, size = 4, colorkey = false } -- Leave same as thin for seamlessness
local tall_percent = { enabled = false, x = 1300, y = 850, size = 6 }              -- Leave same as thin for seamlessness

local stretched_measure = false


-- ==== KEYBINDS ====
-- resolution change actions
local thin = { key = "*-Alt_L", f3_safe = false }
local wide = { key = "*-B", f3_safe = true }
local tall = { key = "*-F4", f3_safe = false }

-- startup actions
local launch_paceman_key = "Shift-P"
local toggle_fullscreen_key = "Shift-O"

-- during game actions
local toggle_ninbot_key = "*-apostrophe"
local toggle_remaps_key = "Insert"


-- ==== MISC ====
local remaps_text_config = { text = "rebinds off", x = 100, y = 100, size = 2 }
local res_1440 = false
local sens_change = { enabled = false, normal = 1.0, tall = 0.1 } -- make sure raw input is off



















-- ======== EXPORT ========
return {
    bg_col = bg_col,
    toggle_bg_picture = toggle_bg_picture,
    primary_col = primary_col,
    secondary_col = secondary_col,
    ninbot_anchor = ninbot_anchor,
    ninbot_opacity = ninbot_opacity,
    res_1440 = res_1440,

    e_count = e_count,
    thin_pie = thin_pie,
    thin_percent = thin_percent,
    tall_pie = tall_pie,
    tall_percent = tall_percent,

    stretched_measure = stretched_measure,

    thin = thin,
    wide = wide,
    tall = tall,
    launch_paceman_key = launch_paceman_key,
    toggle_fullscreen_key = toggle_fullscreen_key,
    toggle_ninbot_key = toggle_ninbot_key,
    toggle_remaps_key = toggle_remaps_key,

    remaps_text_config = remaps_text_config,
    sens_change = sens_change,
}
