-- Import from config.lua
local cfg = require("config")

local bg_col = cfg.bg_col
local toggle_bg_picture = cfg.toggle_bg_picture
local primary_col = cfg.primary_col
local secondary_col = cfg.secondary_col
local ninbot_anchor = cfg.ninbot_anchor
local ninbot_opacity = cfg.ninbot_opacity
local res_1440 = cfg.res_1440

local e_count = cfg.e_count
local thin_pie = cfg.thin_pie
local thin_percent = cfg.thin_percent
local tall_pie = cfg.tall_pie
local tall_percent = cfg.tall_percent

local stretched_measure = cfg.stretched_measure

local thin = cfg.thin

local wide = cfg.wide
local tall = cfg.tall
local launch_paceman_key = cfg.launch_paceman_key
local toggle_fullscreen_key = cfg.toggle_fullscreen_key
local toggle_ninbot_key = cfg.toggle_ninbot_key
local toggle_remaps_key = cfg.toggle_remaps_key

local remaps_config = cfg.remaps_config
local remaps_text_config = cfg.remaps_text_config
local enable_resize_animations = cfg.enable_resize_animations

local sens_change = cfg.sens_change

-- Other inits
local waywall_config_path = os.getenv("HOME") .. "/.config/waywall/"
local bg_path = waywall_config_path .. "resources/background.png"
local tall_overlay_path = waywall_config_path .. "resources/overlay_tall.png"
local thin_overlay_path = waywall_config_path .. "resources/overlay_thin.png"
local wide_overlay_path = waywall_config_path .. "resources/overlay_wide.png"

local pacem_path = waywall_config_path .. "resources/paceman-tracker-0.7.1.jar"
local nb_path = waywall_config_path .. "resources/Ninjabrain-Bot-1.5.1.jar"
local overlay_path = waywall_config_path .. "resources/measuring_overlay.png"
local stretched_overlay_path = waywall_config_path .. "resources/stretched_overlay.png"

local keyboard_remaps = require("remaps").remapped_kb
local other_remaps = require("remaps").normal_kb
local remaps_active = true

local waywall = require("waywall")
local helpers = require("waywall.helpers")

local config = {
    input = {
        layout = (remaps_config.enabled and remaps_config.layout_name) or "us",
        repeat_rate = 40,
        repeat_delay = 300,
        remaps = keyboard_remaps,
        sensitivity = (sens_change.enabled and sens_change.normal) or 1.0,
        confine_pointer = false,
    },
    theme = {
        background = bg_col,
        background_png = toggle_bg_picture and bg_path or nil,
        ninb_anchor = ninbot_anchor,
        ninb_opacity = ninbot_opacity,
    },
    experimental = {
        debug = false,
        jit = false,
        tearing = false,
        scene_add_text = true,
    },
}


--*********************************************************************************************** PACEMAN
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


--*********************************************************************************************** NINJABRAIN
local is_ninb_running = function()
    local handle = io.popen("pgrep -f 'Ninjabrain.*jar'")
    local result = handle:read("*l")
    handle:close()
    return result ~= nil
end

local exec_ninb = function()
    if not is_ninb_running() then
        waywall.exec("java -Dawt.useSystemAAFontSettings=on -jar " .. nb_path)
    end
end

--*********************************************************************************************** MIRRORS
local make_mirror = function(options)
    local this = nil

    return function(enable)
        if enable and not this then
            this = waywall.mirror(options)
        elseif this and not enable then
            this:close()
            this = nil
        end
    end
end

local mirrors = {
    e_counter = make_mirror({
        src = { x = 13, y = 37, w = 37, h = 9 },
        dst = { x = e_count.x, y = e_count.y, w = 37 * e_count.size, h = 9 * e_count.size },
        color_key = e_count.colorkey and {
            input = "#dddddd",
            output = primary_col,
        } or nil,
    }),


    thin_pie_all = make_mirror({
        src = res_1440
            and { x = 10, y = 694, w = 340, h = 221 }
            or { x = 0, y = 674, w = 340, h = 221 },
        dst = { x = thin_pie.x, y = thin_pie.y, w = 420 * thin_pie.size / 4, h = 273 * thin_pie.size / 4 },
    }),

    thin_pie_entities = make_mirror({
        src = res_1440
            and { x = 10, y = 694, w = 340, h = 178 }
            or { x = 0, y = 674, w = 340, h = 178 },
        dst = { x = thin_pie.x, y = thin_pie.y, w = 420 * thin_pie.size / 4, h = 423 * thin_pie.size / 4 },
        color_key = {
            input = "#E446C4",
            output = secondary_col,
        },
    }),
    thin_pie_unspecified = make_mirror({
        src = res_1440
            and { x = 10, y = 694, w = 340, h = 178 }
            or { x = 0, y = 674, w = 340, h = 178 },
        dst = { x = thin_pie.x, y = thin_pie.y, w = 420 * thin_pie.size / 4, h = 423 * thin_pie.size / 4 },
        color_key = {
            input = "#46CE66",
            output = secondary_col,
        },
    }),
    thin_pie_blockentities = make_mirror({
        src = res_1440
            and { x = 10, y = 694, w = 340, h = 178 }
            or { x = 0, y = 674, w = 340, h = 178 },
        dst = { x = thin_pie.x, y = thin_pie.y, w = 420 * thin_pie.size / 4, h = 423 * thin_pie.size / 4 },
        color_key = {
            input = "#ec6e4e",
            output = primary_col,
        },
    }),
    thin_pie_destroyProgress = make_mirror({
        src = res_1440
            and { x = 10, y = 694, w = 340, h = 178 }
            or { x = 0, y = 674, w = 340, h = 178 },
        dst = { x = thin_pie.x, y = thin_pie.y, w = 420 * thin_pie.size / 4, h = 423 * thin_pie.size / 4 },
        color_key = {
            input = "#CC6C46",
            output = secondary_col,
        },
    }),
    thin_pie_prepare = make_mirror({
        src = res_1440
            and { x = 10, y = 694, w = 340, h = 178 }
            or { x = 0, y = 674, w = 340, h = 178 },
        dst = { x = thin_pie.x, y = thin_pie.y, w = 420 * thin_pie.size / 4, h = 423 * thin_pie.size / 4 },
        color_key = {
            input = "#464C46",
            output = secondary_col,
        },
    }),


    thin_percent_all = make_mirror({
        src = res_1440
            and { x = 257, y = 879, w = 33, h = 25 }
            or { x = 247, y = 859, w = 33, h = 25 },
        dst = { x = thin_percent.x, y = thin_percent.y, w = 33 * thin_percent.size, h = 25 * thin_percent.size },
    }),
    thin_percent_blockentities = make_mirror({
        src = res_1440
            and { x = 257, y = 879, w = 33, h = 25 }
            or { x = 247, y = 859, w = 33, h = 25 },
        dst = { x = thin_percent.x, y = thin_percent.y, w = 33 * thin_percent.size, h = 25 * thin_percent.size },
        color_key = {
            input = "#e96d4d",
            output = secondary_col,
        },
    }),
    thin_percent_unspecified = make_mirror({
        src = res_1440
            and { x = 257, y = 879, w = 33, h = 25 }
            or { x = 247, y = 859, w = 33, h = 25 },
        dst = { x = thin_percent.x, y = thin_percent.y, w = 33 * thin_percent.size, h = 25 * thin_percent.size },
        color_key = {
            input = "#45cb65",
            output = secondary_col,
        },
    }),


    tall_pie_all = make_mirror({
        src = { x = 44, y = 15978, w = 340, h = 221 },
        dst = { x = tall_pie.x, y = tall_pie.y, w = 420 * tall_pie.size / 4, h = 273 * tall_pie.size / 4 },
    }),
    tall_pie_entities = make_mirror({
        src = { x = 44, y = 15978, w = 340, h = 178 },
        dst = { x = tall_pie.x, y = tall_pie.y, w = 420 * tall_pie.size / 4, h = 423 * tall_pie.size / 4 },
        color_key = {
            input = "#E446C4",
            output = secondary_col,
        },
    }),
    tall_pie_unspecified = make_mirror({
        src = { x = 44, y = 15978, w = 340, h = 178 },
        dst = { x = tall_pie.x, y = tall_pie.y, w = 420 * tall_pie.size / 4, h = 423 * tall_pie.size / 4 },
        color_key = {
            input = "#46CE66",
            output = secondary_col,
        },
    }),
    tall_pie_blockentities = make_mirror({
        src = { x = 44, y = 15978, w = 340, h = 178 },
        dst = { x = tall_pie.x, y = tall_pie.y, w = 420 * tall_pie.size / 4, h = 423 * tall_pie.size / 4 },
        color_key = {
            input = "#ec6e4e",
            output = primary_col,
        },
    }),
    tall_pie_destroyProgress = make_mirror({
        src = { x = 44, y = 15978, w = 340, h = 178 },
        dst = { x = tall_pie.x, y = tall_pie.y, w = 420 * tall_pie.size / 4, h = 423 * tall_pie.size / 4 },
        color_key = {
            input = "#CC6C46",
            output = secondary_col,
        },
    }),
    tall_pie_prepare = make_mirror({
        src = { x = 44, y = 15978, w = 340, h = 178 },
        dst = { x = tall_pie.x, y = tall_pie.y, w = 420 * tall_pie.size / 4, h = 423 * tall_pie.size / 4 },
        color_key = {
            input = "#464C46",
            output = secondary_col,
        },
    }),


    tall_percent_all = make_mirror({
        src = { x = 291, y = 16163, w = 33, h = 25 },
        dst = { x = tall_percent.x, y = tall_percent.y, w = 33 * tall_percent.size, h = 25 * tall_percent.size },
    }),
    tall_percent_blockentities = make_mirror({
        src = { x = 291, y = 16163, w = 33, h = 25 },
        dst = { x = tall_percent.x, y = tall_percent.y, w = 33 * tall_percent.size, h = 25 * tall_percent.size },
        color_key = {
            input = "#e96d4d",
            output = secondary_col,
        },
    }),
    tall_percent_unspecified = make_mirror({
        src = { x = 291, y = 16163, w = 33, h = 25 },
        dst = { x = tall_percent.x, y = tall_percent.y, w = 33 * tall_percent.size, h = 25 * tall_percent.size },
        color_key = {
            input = "#45cb65",
            output = secondary_col,
        },
    }),


    eye_measure = make_mirror({
        src = stretched_measure
            and { x = 177, y = 7902, w = 30, h = 580 }
            or { x = 162, y = 7902, w = 60, h = 580 },
        dst = res_1440
            and { x = 94, y = 470, w = 900, h = 500 }
            or { x = 30, y = 340, w = 700, h = 400 },
    }),
}


--*********************************************************************************************** BOATEYE
local make_image = function(path, dst)
    local this = nil

    return function(enable)
        if enable and not this then
            this = waywall.image(path, dst)
        elseif this and not enable then
            this:close()
            this = nil
        end
    end
end

local images = {
    measuring_overlay = make_image(overlay_path, {
        dst = res_1440
            and { x = 94, y = 470, w = 900, h = 500 }
            or { x = 30, y = 340, w = 700, h = 400 },
    }),
    stretched_overlay = make_image(stretched_overlay_path, {
        dst = res_1440
            and { x = 94, y = 470, w = 900, h = 500 }
            or { x = 30, y = 340, w = 700, h = 400 },
    }),
    tall_overlay = make_image(tall_overlay_path, {
        dst = res_1440
            and { x = 0, y = 0, w = 2560, h = 1440 }
            or { x = 0, y = 0, w = 1920, h = 1080 },
    }),
    thin_overlay = make_image(thin_overlay_path, {
        dst = res_1440
            and { x = 0, y = 0, w = 2560, h = 1440 }
            or { x = 0, y = 0, w = 1920, h = 1080 },
    }),
    wide_overlay = make_image(wide_overlay_path, {
        dst = res_1440
            and { x = 0, y = 0, w = 2560, h = 1440 }
            or { x = 0, y = 0, w = 1920, h = 1080 },
    }),

}


--*********************************************************************************************** MANAGING MIRRORS
local show_mirrors = function(eye, f3, tall, thin, wide)
    images.tall_overlay(tall)
    images.thin_overlay(thin)
    images.wide_overlay(wide)

    mirrors.eye_measure(eye)
    if stretched_measure then
        images.stretched_overlay(eye)
    else
        images.measuring_overlay(eye)
    end

    if e_count.enabled then
        mirrors.e_counter(f3)
    end

    if thin_pie.enabled then
        if thin_pie.colorkey then
            mirrors.thin_pie_entities(thin)
            mirrors.thin_pie_unspecified(thin)
            mirrors.thin_pie_blockentities(thin)
            mirrors.thin_pie_destroyProgress(thin)
            mirrors.thin_pie_prepare(thin)
        else
            mirrors.thin_pie_all(thin)
        end
    end

    if thin_percent.enabled then
        mirrors.thin_percent_blockentities(thin)
        mirrors.thin_percent_unspecified(thin)
    end

    if tall_pie.enabled then
        if tall_pie.colorkey then
            mirrors.tall_pie_entities(tall)
            mirrors.tall_pie_unspecified(tall)
            mirrors.tall_pie_blockentities(tall)
            mirrors.tall_pie_destroyProgress(tall)
            mirrors.tall_pie_prepare(tall)
        else
            mirrors.tall_pie_all(tall)
        end
    end

    if tall_percent.enabled then
        mirrors.tall_percent_blockentities(tall)
        mirrors.tall_percent_unspecified(tall)
    end
end


--*********************************************************************************************** STATES
local thin_enable = function()
    show_mirrors(false, true, false, true, false)
end

local tall_enable = function()
    show_mirrors(true, true, true, false, false)
    if sens_change.enabled then
        waywall.set_sensitivity(sens_change.tall)
    end
end
local wide_enable = function()
    show_mirrors(false, false, false, false, true)
end

local res_disable = function()
    show_mirrors(false, false, false, false, false)
end

local tall_disable = function()
    show_mirrors(false, false, false, false, false)
    if sens_change.enabled then
        waywall.set_sensitivity(sens_change.normal)
    end
end

--*********************************************************************************************** RESOLUTIONS
local make_res = function(width, height, enable, disable)
    return function()
        local active_width, active_height = waywall.active_res()

        if active_width == width and active_height == height then
            if enable_resize_animations then
                os.execute('echo "0x0" > ~/.resetti_state')
                waywall.sleep(17)
            end
            waywall.set_resolution(0, 0)
            disable()
        else
            if enable_resize_animations then
                os.execute(string.format('echo "%dx%d" > ~/.resetti_state', width, height))
                waywall.sleep(17)
            end
            waywall.set_resolution(width, height)
            enable()
        end
    end
end


local resolutions = {
    thin = make_res(res_1440 and 350 or 340, res_1440 and 1100 or 1080, thin_enable, res_disable),
    tall = make_res(384, 16384, tall_enable, tall_disable),
    wide = make_res(res_1440 and 2560 or 1920, res_1440 and 400 or 300, wide_enable, res_disable),
}

local rebind_text = nil

--*********************************************************************************************** KEYBINDS

local function resize_helper(mode, run)
    return function()
        if not remaps_active then
            return false
        end
        if mode.f3_safe and waywall.get_key("F3") then
            return false
        end
        run()
    end
end

config.actions = {

    [thin.key] = resize_helper(thin, function() resolutions.thin() end),
    [wide.key] = resize_helper(wide, function() resolutions.wide() end),
    [tall.key] = resize_helper(tall, function() resolutions.tall() end),

    [toggle_ninbot_key] = function()
        if not is_ninb_running() then
            waywall.exec("java -Dawt.useSystemAAFontSettings=on -jar " .. nb_path)
            waywall.show_floating(true)
        else
            helpers.toggle_floating()
        end
    end,

    [toggle_fullscreen_key] = waywall.toggle_fullscreen,

    [launch_paceman_key] = function()
        exec_pacem()
    end,

    [toggle_remaps_key] = function()
        if rebind_text then
            rebind_text:close()
            rebind_text = nil
        end
        if remaps_active then
            remaps_active = false
            waywall.set_remaps(other_remaps)
            if remaps_config.enabled then waywall.set_keymap({ layout = remaps_config.layout_name }) end
        else
            remaps_active = true
            waywall.set_remaps(keyboard_remaps)
            if remaps_config.enabled then waywall.set_keymap({ layout = remaps_config.layout_name }) end
            rebind_text = waywall.text(remaps_text_config.text,
                { x = remaps_text_config.x, y = remaps_text_config.y, color = "#FFFFFF", size = remaps_text_config.size })
        end
    end,


}


return config
