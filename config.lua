-- ======== WAYWALL GENERIC CONFIG ========
return {
    -- ==== LOOKS ====
    bg_col = "#000000",
    toggle_bg_picture = false,
    text_col = "#FFFFFF",
    pie_chart_1 = "#EC6E4E",
    pie_chart_2 = "#E446C4",
    pie_chart_3 = "#46CE66",


    ninbot_anchor = "topright", -- topleft, top, topright, left, right, bottomleft, bottomright
    ninbot_opacity = 1,         -- 0 to 1


    -- ==== MIRRORS ====
    e_count = { enabled = true, x = 1340, y = 300, size = 5, colorkey = false },
    thin_pie = { enabled = true, x = 1250, y = 500, size = 4, colorkey = false }, -- Turning off colorkeying also maintains the original pie chart's dimensions and shows the percentages
    thin_percent = { enabled = false, x = 1300, y = 850, size = 6 },
    tall_pie = { enabled = true, x = 1250, y = 500, size = 4, colorkey = false }, -- Leave same as thin for seamlessness
    tall_percent = { enabled = false, x = 1300, y = 850, size = 6 },              -- Leave same as thin for seamlessness

    stretched_measure = false,


    -- ==== KEYBINDS ====
    -- resolution change actions
    thin = { key = "*-Alt_L", f3_safe = false },
    wide = { key = "*-B", f3_safe = true },
    tall = { key = "*-F4", f3_safe = false },

    -- startup actions
    toggle_fullscreen_key = "Shift-O",
    launch_paceman_key = "Shift-P",

    -- during game actions
    toggle_ninbot_key = "*-apostrophe",
    toggle_remaps_key = "Insert",


    -- ==== MISC ====
    remaps_config = { layout_name = "mc", enabled = false }, -- ~/.config/xkb/symbols/mc
    remaps_text_config = { text = "remaps off", x = 100, y = 100, size = 2 },
    res_1440 = false,
    sens_change = { enabled = false, normal = 1.0, tall = 0.1 }, -- make sure raw input is off
    enable_resize_animations = false,

}
