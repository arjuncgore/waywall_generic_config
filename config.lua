-- ==== WAYWALL GENERIC CONFIG ====
return {
    -- ==== LOOKS ====
    bg_col = "#000000",
    toggle_bg_picture = false,
    text_col = "#FFFFFF",
    pie_chart_1 = "#EC6E4E",
    pie_chart_2 = "#46CE66",
    pie_chart_3 = "#E446C4",

    ninbot_anchor = {
        position = "topright", -- topleft, top, topright, left, right, bottomleft, bottomright
        x = 0, y = 130, -- offset
    },
    ninbot_opacity = 1, -- 0 to 1


    -- ==== MIRRORS ====
    e_count = { enabled = true, x = 1500, y = 400, size = 5, colorkey = false },
    thin_pie = { enabled = true, x = 1490, y = 645, size = 4, colorkey = false }, -- Turning off colorkeying also maintains the original pie chart's dimensions and shows the percentages
    thin_percent = { enabled = false, x = 1568, y = 1050, size = 6 },
    tall_pie = { enabled = true, x = 1490, y = 645, size = 4, colorkey = false }, -- Leave same as thin for seamlessness
    tall_percent = { enabled = false, x = 1568, y = 1050, size = 6 },             -- Leave same as thin for seamlessness

    stretched_measure = false,


    -- ==== KEYBINDS ====
    -- resolution changes
    thin = { key = "*-Alt_L", f3_safe = false, ingame_only = true },
    wide = { key = "*-B", f3_safe = true, ingame_only = true },
    tall = { key = "*-F4", f3_safe = false, ingame_only = false },

    -- startup actions
    toggle_fullscreen_key = "Shift-O",
    launch_paceman_key = "Shift-P",

    -- during game actions
    toggle_ninbot_key = "*-apostrophe",
    toggle_remaps_key = "Insert",

    
    -- ==== KEYBOARD ====
    xkb_config = { -- set any setting to nil if unwanted
        enabled = false,
        layout = "mc", -- ~/.config/xkb/symbols/mc
        rules = nil,  -- ~/.config/xkb/rules/...
        variant = "basic",
        options = "caps:none",
    },
    remaps_text_config = { text = "chat mode", x = 100, y = 100, size = 2, color = "#000000" },


    -- ==== MISC ====
    res_1440 = true,
    sens_change = { enabled = false, normal = 1.0, tall = 0.1 }, -- make sure raw input is off
    enable_resize_animations = false,

}
