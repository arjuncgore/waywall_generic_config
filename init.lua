-- ==== WAYWALL ====
local waywall = require("waywall")
local helpers = require("waywall.helpers")


-- ==== USER CONFIG ====
local cfg = require("config")
local keyboard_remaps = require("remaps").remapped_kb
local other_remaps = require("remaps").normal_kb


-- ==== RESOURCES ====
local waywall_config_path = os.getenv("HOME") .. "/.config/waywall/"
local bg_path = waywall_config_path .. "resources/background.png"
local tall_overlay_path = waywall_config_path .. "resources/overlay_tall.png"
local thin_overlay_path = waywall_config_path .. "resources/overlay_thin.png"
local wide_overlay_path = waywall_config_path .. "resources/overlay_wide.png"

local pacem_path = waywall_config_path .. "resources/paceman-tracker-0.7.1.jar"
local nb_path = waywall_config_path .. "resources/Ninjabrain-Bot-1.5.1.jar"
local overlay_path = waywall_config_path .. "resources/measuring_overlay.png"
local stretched_overlay_path = waywall_config_path .. "resources/stretched_overlay.png"


-- ==== INITS ====
local remaps_active = true
local rebind_text = nil
local thin_active = false


-- ==== CONFIG TABLE ====
local config = {
    input = {
        layout = (cfg.xkb_config.enabled and cfg.xkb_config.layout) or nil,
        rules = (cfg.xkb_config.enabled and cfg.xkb_config.rules) or nil,
        variant = (cfg.xkb_config.enabled and cfg.xkb_config.variant) or nil,
        options = (cfg.xkb_config.enabled and cfg.xkb_config.options) or nil,

        repeat_rate = 40,
        repeat_delay = 300,
        remaps = keyboard_remaps,
        sensitivity = (cfg.sens_change.enabled and cfg.sens_change.normal) or 1.0,
        confine_pointer = false,
    },
    theme = {
        background = cfg.bg_col,
        background_png = cfg.toggle_bg_picture and bg_path or nil,
        ninb_anchor = cfg.ninbot_anchor,
        ninb_opacity = cfg.ninbot_opacity,
    },
    experimental = {
        debug = false,
        jit = false,
        tearing = false,
    },
}


-- ==== PACEMAN ====
local is_pacem_running = function()
    local handle = io.popen("pgrep -f 'paceman..*'")
    local result = handle:read("*l")
    handle:close()
    return result ~= nil
end

local exec_pacem = function()
    if not is_pacem_running() then
        waywall.exec("java -jar " .. pacem_path .. " --nogui")
    end
end


-- ==== NINJABRAIN ====
local is_ninb_running = function()
    local handle = io.popen("pgrep -f 'Ninjabrain.*jar'")
    local result = handle:read("*l")
    handle:close()
    return result ~= nil
end


-- ==== MIRRORS ====
-- == helpers ==
local mir_e_counter = {
    src = { x = 13, y = 37, w = 37, h = 9 },
    dst = { x = cfg.e_count.x, y = cfg.e_count.y, w = 37 * cfg.e_count.size, h = 9 * cfg.e_count.size },
    color_key = cfg.e_count.colorkey and {
        input = "#DDDDDD",
        output = cfg.text_col,
    } or nil
}
local mir_thin_pie_all = {
    src = cfg.res_1440
        and { x = 10, y = 694, w = 340, h = 221 }
        or  { x = 0,  y = 674, w = 340, h = 221 },
    dst = {
        x = cfg.thin_pie.x,
        y = cfg.thin_pie.y,
        w = 420 * cfg.thin_pie.size / 4,
        h = 273 * cfg.thin_pie.size / 4,
    },
}
local mir_thin_pie_segment = {
    src = cfg.res_1440
        and { x = 10, y = 694, w = 340, h = 178 }
        or  { x = 0,  y = 674, w = 340, h = 178 },
    dst = {
        x = cfg.thin_pie.x,
        y = cfg.thin_pie.y,
        w = 420 * cfg.thin_pie.size / 4,
        h = 423 * cfg.thin_pie.size / 4,
    },
}
local mir_thin_percent_all = {
    src = cfg.res_1440
        and { x = 257, y = 879, w = 33, h = 25 }
        or  { x = 247, y = 859, w = 33, h = 25 },
    dst = {
        x = cfg.thin_percent.x,
        y = cfg.thin_percent.y,
        w = 33 * cfg.thin_percent.size,
        h = 25 * cfg.thin_percent.size,
    },
}
local mir_tall_pie_all = {
    src = { x = 44, y = 15978, w = 340, h = 221 },
    dst = {
        x = cfg.tall_pie.x,
        y = cfg.tall_pie.y,
        w = 420 * cfg.tall_pie.size / 4,
        h = 273 * cfg.tall_pie.size / 4,
    },
}
local mir_tall_pie_segment = {
    src = { x = 44, y = 15978, w = 340, h = 178 },
    dst = {
        x = cfg.tall_pie.x,
        y = cfg.tall_pie.y,
        w = 420 * cfg.tall_pie.size / 4,
        h = 423 * cfg.tall_pie.size / 4,
    },
}
local mir_tall_percent_all = {
    src = { x = 291, y = 16163, w = 33, h = 25 },
    dst = {
        x = cfg.tall_percent.x,
        y = cfg.tall_percent.y,
        w = 33 * cfg.tall_percent.size,
        h = 25 * cfg.tall_percent.size,
    },
}
local mir_eye_measure = {
    src = cfg.stretched_measure
        and { x = 177, y = 7902, w = 30, h = 580 }
        or  { x = 162, y = 7902, w = 60, h = 580 },
    dst = cfg.res_1440
        and { x = 94, y = 470, w = 900, h = 500 }
        or  { x = 30, y = 340, w = 700, h = 400 },
}
local base_w = cfg.res_1440 and 350 or 340
local base_h = cfg.res_1440 and 1100 or 1080

-- == thin ==
helpers.res_mirror( -- thin e_counter
    mir_e_counter,
    base_w, base_h
)

helpers.res_mirror( -- thin pie (all)
    mir_thin_pie_all,
    base_w, base_h
)
helpers.res_mirror( -- thin pie blockentities
    vim.tbl_extend("force", mir_thin_pie_segment, {
        color_key = { input = "#EC6E4E", output = cfg.pie_chart_1 },
    }),
    base_w, base_h
)
helpers.res_mirror( -- thin pie unspecified
    vim.tbl_extend("force", mir_thin_pie_segment, {
        color_key = { input = "#46CE66", output = cfg.pie_chart_2 },
    }),
    base_w, base_h
)
helpers.res_mirror( -- thin pie destroyProgress
    vim.tbl_extend("force", mir_thin_pie_segment, {
        color_key = { input = "#CC6C46", output = cfg.pie_chart_2 },
    }),
    base_w, base_h
)
helpers.res_mirror( -- thin pie prepare
    vim.tbl_extend("force", mir_thin_pie_segment, {
        color_key = { input = "#464C46", output = cfg.pie_chart_2 },
    }),
    base_w, base_h
)
helpers.res_mirror( -- thin pie entities
    vim.tbl_extend("force", mir_thin_pie_segment, {
        color_key = { input = "#E446C4", output = cfg.pie_chart_3 },
    }),
    base_w, base_h
)
helpers.res_mirror( -- thin percent blockentities
    vim.tbl_extend("force", mir_thin_percent_all, {
        color_key = { input = "#E96D4D", output = cfg.text_col },
    }),
    base_w, base_h
)
helpers.res_mirror( -- thin percent unspecified
    vim.tbl_extend("force", mir_thin_percent_all, {
        color_key = { input = "#45CB65", output = cfg.text_col },
    }),
    base_w, base_h
)