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

local pacem_path = waywall_config_path .. "resources/paceman-tracker-0.7.2.jar"
local nb_path = waywall_config_path .. "resources/Ninjabrain-Bot-1.5.1.jar"
local overlay_path = waywall_config_path .. "resources/measuring_overlay.png"
local stretched_overlay_path = waywall_config_path .. "resources/stretched_overlay.png"

-- ==== INITS ====
local remaps_active = true
local rebind_text = nil
local thin_active = false
local keybinds_text = nil
local debug_text1 = nil
local debug_text2 = nil
local debug_text3 = nil
local debug_text4 = nil
local debug_text = "Press Shift + I to show keybinds.\n\n" ..
    "Look at the Github's README for a guide to config.\n\n" ..
    "disable this message by setting\n" ..
    "\'debug_text\' to false in ~/.config/waywall/config.lua\n"

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

-- ==== TOOLS ====
local is_ninb_running = function()
    local handle = io.popen("ps aux | grep '[N]injabrain-Bot.*\\.jar'")
    local result = handle:read("*l")
    handle:close()
    return result ~= nil
end
local is_pacem_running = function()
    local handle = io.popen("ps aux | grep '[p]aceman-tracker.*\\.jar'")
    local result = handle:read("*l")
    handle:close()
    return result ~= nil
end

-- ==== MIRRORS ====
-- colors
local pie_colors = {
    { input = "#EC6E4E", output = cfg.pie_chart_1 },
    { input = "#46CE66", output = cfg.pie_chart_2 },
    { input = "#CC6C46", output = cfg.pie_chart_2 },
    { input = "#464C46", output = cfg.pie_chart_2 },
    { input = "#E446C4", output = cfg.pie_chart_3 }
}
local percentage_colors = {
    { input = "#E96D4D", output = cfg.text_col },
    { input = "#45CB65", output = cfg.text_col }
}

-- resolutions
local THIN_W, THIN_H = (cfg.res_1440 and 350 or 340), (cfg.res_1440 and 1100 or 1080)
local WIDE_W, WIDE_H = (cfg.res_1440 and 2560 or 1920), (cfg.res_1440 and 400 or 300)
local TALL_W, TALL_H = 384, 16384

-- thin mirrors
if cfg.e_count.enabled then
    helpers.res_mirror(
        {
            src = { x = 13, y = 37, w = 37, h = 9 },
            dst = { x = cfg.e_count.x, y = cfg.e_count.y, w = 37 * cfg.e_count.size, h = 9 * cfg.e_count.size },
            depth = 2,
            color_key = cfg.e_count.colorkey and {
                input = "#DDDDDD",
                output = cfg.text_col,
            } or nil,
        },
        THIN_W, THIN_H
    )
    helpers.res_mirror(
        {
            src = { x = 13, y = 37, w = 37, h = 9 },
            dst = { x = cfg.e_count.x, y = cfg.e_count.y, w = 37 * cfg.e_count.size, h = 9 * cfg.e_count.size },
            depth = 2,
            color_key = cfg.e_count.colorkey and {
                input = "#DDDDDD",
                output = cfg.text_col,
            } or nil,
        },
        TALL_W, TALL_H
    )
end

if cfg.thin_pie.enabled then
    if cfg.thin_pie.colorkey then
        for _, ck in ipairs(pie_colors) do
            helpers.res_mirror(
                {
                    src = cfg.res_1440
                        and { x = 10, y = 694, w = 340, h = 178 }
                        or { x = 0, y = 674, w = 340, h = 178 },
                    dst = { x = cfg.thin_pie.x, y = cfg.thin_pie.y, w = 420 * cfg.thin_pie.size / 4, h = 423 * cfg.thin_pie.size / 4 },
                    depth = 2,
                    color_key = ck,
                },
                THIN_W, THIN_H
            )
        end
    else
        helpers.res_mirror(
            {
                src = cfg.res_1440
                    and { x = 10, y = 694, w = 340, h = 221 }
                    or { x = 0, y = 674, w = 340, h = 221 },
                dst = { x = cfg.thin_pie.x, y = cfg.thin_pie.y, w = 420 * cfg.thin_pie.size / 4, h = 273 * cfg.thin_pie.size / 4 },
                depth = 2,
            },
            THIN_W, THIN_H
        )
    end
end

if cfg.thin_percent.enabled then
    for _, ck in ipairs(percentage_colors) do
        helpers.res_mirror(
            {
                src = cfg.res_1440
                    and { x = 257, y = 879, w = 33, h = 25 }
                    or { x = 247, y = 859, w = 33, h = 25 },
                dst = { x = cfg.thin_percent.x, y = cfg.thin_percent.y, w = 33 * cfg.thin_percent.size, h = 25 * cfg.thin_percent.size },
                depth = 3,
                color_key = ck,
            },
            THIN_W, THIN_H
        )
    end
end

-- tall mirrors
if cfg.tall_pie.enabled then
    if cfg.tall_pie.colorkey then
        for _, ck in ipairs(pie_colors) do
            helpers.res_mirror(
                {
                    src = { x = 44, y = 15978, w = 340, h = 178 },
                    dst = { x = cfg.tall_pie.x, y = cfg.tall_pie.y, w = 420 * cfg.tall_pie.size / 4, h = 423 * cfg.tall_pie.size / 4 },
                    depth = 2,
                    color_key = ck,
                },
                TALL_W, TALL_H
            )
        end
    else
        helpers.res_mirror(
            {
                src = { x = 44, y = 15978, w = 340, h = 221 },
                dst = { x = cfg.tall_pie.x, y = cfg.tall_pie.y, w = 420 * cfg.tall_pie.size / 4, h = 273 * cfg.tall_pie.size / 4 },
                depth = 2,
            },
            TALL_W, TALL_H
        )
    end
end

if cfg.tall_percent.enabled then
    for _, ck in ipairs(percentage_colors) do
        helpers.res_mirror(
            {
                src = { x = 291, y = 16163, w = 33, h = 25 },
                dst = { x = cfg.tall_percent.x, y = cfg.tall_percent.y, w = 33 * cfg.tall_percent.size, h = 25 * cfg.tall_percent.size },
                depth = 3,
                color_key = ck,
            },
            TALL_W, TALL_H
        )
    end
end

helpers.res_mirror(
    {
        src = cfg.stretched_measure
            and { x = 177, y = 7902, w = 30, h = 580 }
            or { x = 162, y = 7902, w = 60, h = 580 },
        dst = cfg.res_1440
            and { x = 94, y = 470, w = 900, h = 500 }
            or { x = 30, y = 340, w = 700, h = 400 },
        depth = 2,
    },
    TALL_W, TALL_H
)

-- ==== IMAGES ====
helpers.res_image(
    cfg.stretched_measure and stretched_overlay_path or overlay_path,
    {
        dst = cfg.res_1440
            and { x = 94, y = 470, w = 900, h = 500 }
            or { x = 30, y = 340, w = 700, h = 400 },
        depth = 3,
    },
    TALL_W, TALL_H
)
helpers.res_image(
    tall_overlay_path,
    {
        dst = cfg.res_1440
            and { x = 0, y = 0, w = 2560, h = 1440 }
            or { x = 0, y = 0, w = 1920, h = 1080 },
        depth = 1,
    },
    TALL_W, TALL_H
)
helpers.res_image(
    wide_overlay_path,
    {
        dst = cfg.res_1440
            and { x = 0, y = 0, w = 2560, h = 1440 }
            or { x = 0, y = 0, w = 1920, h = 1080 },
        depth = 1,
    },
    WIDE_W, WIDE_H
)
helpers.res_image(
    thin_overlay_path,
    {
        dst = cfg.res_1440
            and { x = 0, y = 0, w = 2560, h = 1440 }
            or { x = 0, y = 0, w = 1920, h = 1080 },
        depth = 1,
    },
    THIN_W, THIN_H
)

-- ==== DEBUG TEXT ====
waywall.listen("load", function()
    if cfg.debug_text then
        debug_text1 = waywall.text(debug_text,
            { x = 10, y = 10, color = "#FFFF00", size = 3 })
        debug_text2 = waywall.text(debug_text,
            { x = 11, y = 11, color = "#FFFF00", size = 3 })
        debug_text3 = waywall.text(debug_text,
            { x = 13, y = 13, color = "#000000", size = 3 })
        debug_text4 = waywall.text(debug_text,
            { x = 14, y = 14, color = "#000000", size = 3 })
    end
end)

-- ==== RESIZING STATES ====
local thin_enable = function()
    thin_active = true
    if cfg.sens_change.enabled then
        waywall.set_sensitivity(cfg.sens_change.normal)
    end
end
local tall_enable = function()
    if cfg.sens_change.enabled and not thin_active then
        waywall.set_sensitivity(cfg.sens_change.tall)
    end
    thin_active = false
end
local wide_enable = function()
    if cfg.sens_change.enabled then
        waywall.set_sensitivity(cfg.sens_change.normal)
    end
    thin_active = false
end
local res_disable = function()
    if cfg.sens_change.enabled then
        waywall.set_sensitivity(cfg.sens_change.normal)
    end
    thin_active = false
end

-- ==== RESOLUTIONS ====
local make_res = function(width, height, enable, disable)
    return function()
        local active_width, active_height = waywall.active_res()

        if active_width == width and active_height == height then
            if cfg.enable_resize_animations then
                os.execute('echo "0x0" > ~/.resetti_state')
                waywall.sleep(17)
            end
            waywall.set_resolution(0, 0)
            disable()
        else
            if cfg.enable_resize_animations then
                os.execute(string.format('echo "%dx%d" > ~/.resetti_state', width, height))
                waywall.sleep(17)
            end
            waywall.set_resolution(width, height)
            enable()
        end
    end
end

local resolutions = {
    thin = make_res(THIN_W, THIN_H, thin_enable, res_disable),
    tall = make_res(TALL_W, TALL_H, tall_enable, res_disable),
    wide = make_res(WIDE_W, WIDE_H, wide_enable, res_disable),
}

local function resize_helper(mode, run, ingame_only)
    local resize = function()
        if not remaps_active then
            return false
        end
        if mode.f3_safe and waywall.get_key("F3") then
            return false
        end
        return run()
    end

    if ingame_only then
        return helpers.ingame_only(resize)
    end

    return resize
end

-- ==== KEYBINDS ====
config.actions = {

    [cfg.thin.key] = resize_helper(cfg.thin, resolutions.thin, cfg.thin.ingame_only),
    [cfg.wide.key] = resize_helper(cfg.wide, resolutions.wide, cfg.wide.ingame_only),
    [cfg.tall.key] = resize_helper(cfg.tall, resolutions.tall, cfg.tall.ingame_only),

    [cfg.toggle_fullscreen_key] = waywall.toggle_fullscreen,

    [cfg.launch_paceman_key] = function()
        if is_pacem_running() then
            print("Paceman Already Running")
        else
            waywall.exec("java -jar " .. pacem_path .. " --nogui")
            print("Paceman Running")
        end
    end,

    [cfg.toggle_ninbot_key] = function()
        if not is_ninb_running() then
            waywall.exec("java -Dawt.useSystemAAFontSettings=on -jar " .. nb_path)
            waywall.show_floating(true)
        else
            helpers.toggle_floating()
        end
    end,

    [cfg.toggle_remaps_key] = function()
        if rebind_text then
            rebind_text:close()
            rebind_text = nil
        end
        if remaps_active then
            remaps_active = false
            waywall.set_remaps(other_remaps)

            if cfg.xkb_config.enabled then
                waywall.set_keymap({
                    layout = nil,
                    rules = nil,
                    variant = nil,
                    options = nil,
                })
            end

            rebind_text = waywall.text(cfg.remaps_text_config.text,
                {
                    x = cfg.remaps_text_config.x,
                    y = cfg.remaps_text_config.y,
                    color = cfg.remaps_text_config.color,
                    size = cfg.remaps_text_config.size
                })
        else
            remaps_active = true
            waywall.set_remaps(keyboard_remaps)

            if cfg.xkb_config.enabled then
                waywall.set_keymap({
                    layout = cfg.xkb_config.layout,
                    rules = cfg.xkb_config.rules,
                    variant = cfg.xkb_config.variant,
                    options = cfg.xkb_config.options
                })
            end
        end
    end,

    ["Shift-I"] = function()
        if keybinds_text then
            keybinds_text:close()
            keybinds_text = nil
            return false
        end
        keybinds_text = waywall.text(
            "KEYBINDS:\n" ..
            "Thin = " .. cfg.thin.key .. "\n" ..
            "Wide = " .. cfg.wide.key .. "\n" ..
            "Tall = " .. cfg.tall.key .. "\n" ..
            "Toggle Ninbot = " .. cfg.toggle_ninbot_key .. "\n" ..
            "Launch paceman = " .. cfg.launch_paceman_key .. "\n" ..
            "Fullscreen = " .. cfg.toggle_fullscreen_key .. "\n" ..
            "  "


            ,
            { x = 10, y = 10, color = "#FFFFFF", size = 3 })
        if debug_text1 and debug_text2 and debug_text3 and debug_text4 then
            debug_text1:close()
            debug_text1 = nil
            debug_text2:close()
            debug_text2 = nil
            debug_text3:close()
            debug_text3 = nil
            debug_text4:close()
            debug_text4 = nil
        end
    end

}

require("extras")(config)

return config
