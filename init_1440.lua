local bg_col = "#000000"
local primary_col = "#ec6e4e"
local secondary_col = "#E446C4"

local ninbot_anchor = "topright" -- topleft, top, topright, left, right, bottomleft, bottomright
local ninbot_opacity = 1 -- 0 to 1

-- local pacem_path = "/home/<username>/paceman-tracker-0.7.0.jar"
local nb_path = "/home/<username>/Ninjabrain-Bot-1.5.1.jar"
local overlay_path = "/home/<username>/.config/waywall/measuring_overlay.png"

local e_count = 		{ enabled = true, x = 1500, y = 400, size = 7} 
local thin_pie = 		{ enabled = true, x = 1490, y = 645, size = 1} 
local thin_percent =	{ enabled = true, x = 1568, y = 1050, size = 8} 
local tall_pie = 		{ enabled = true, x = 1490, y = 645, size = 1} -- Leave same as thin for seamlessness
local tall_percent =	{ enabled = true, x = 1568, y = 1050, size = 8} -- Leave same as thin for seamlessness

local thin_key = "*-Alt_L"
local wide_key = "*-B"
local tall_key = "*-F4"
local show_ninbot_key = "*-apostrophe"
local toggle_fullscreen_key = "Shift-O"
local open_ninbot_key = "Shift-P"

local keyboard_remaps = {
	-- ["MB4"] = "F3", -- (example)
}

-- DON'T CHANGE ANYTHING AFTER THIS UNLESS YOU KNOW WHAT YOU"RE DOING

local waywall = require("waywall")
local helpers = require("waywall.helpers")

local config = {
    input = {
        layout = "us",
        repeat_rate = 40,
        repeat_delay = 300,
		remaps = keyboard_remaps,
        sensitivity = 1.0,
        confine_pointer = true,
    },
    theme = {
        background = bg_col,
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
		dst = { x = e_count.x, y = e_count.y, w = 37*e_count.size, h = 9*e_count.size },
		color_key = {
			input = "#dddddd",
			output = primary_col,
		},
	}),


    thin_pie_all = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = thin_pie.x, y = thin_pie.y, w = 420*thin_pie.size, h = 423*thin_pie.size },
    }),
    thin_pie_entities = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = thin_pie.x, y = thin_pie.y, w = 420*thin_pie.size, h = 423*thin_pie.size },
		color_key = {
			input = "#E446C4",
			output = secondary_col,
		},
	}),
    thin_pie_unspecified = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = thin_pie.x, y = thin_pie.y, w = 420*thin_pie.size, h = 423*thin_pie.size },
		color_key = {
			input = "#46CE66",
			output = secondary_col,
		},
	}),
    thin_pie_blockentities = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = thin_pie.x, y = thin_pie.y, w = 420*thin_pie.size, h = 423*thin_pie.size },
		color_key = {
			input = "#ec6e4e",
			output = primary_col,
		},
	}),
	thin_pie_destroyProgress = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = thin_pie.x, y = thin_pie.y, w = 420*thin_pie.size, h = 423*thin_pie.size },
		color_key = {
			input = "#CC6C46",
			output = secondary_col,
		},
	}),
	thin_pie_prepare = make_mirror({
		src = { x = 10, y = 694, w = 340, h = 178 },
		dst = { x = thin_pie.x, y = thin_pie.y, w = 420*thin_pie.size, h = 423*thin_pie.size },
		color_key = {
			input = "#464C46",
			output = secondary_col,
		},
	}),


	thin_percent_all = make_mirror({
		src = { x = 257, y = 879, w = 33, h = 25 },
		dst = { x = thin_percent.x, y = thin_percent.y, w = 33*thin_percent.size, h = 25*thin_percent.size },
    }),
	thin_percent_blockentities = make_mirror({
		src = { x = 257, y = 879, w = 33, h = 25 },
		dst = { x = thin_percent.x, y = thin_percent.y, w = 33*thin_percent.size, h = 25*thin_percent.size },
		color_key = {
			input = "#e96d4d",
			output = secondary_col,
		},
    }),
	thin_percent_unspecified = make_mirror({
		src = { x = 257, y = 879, w = 33, h = 25 },
		dst = { x = thin_percent.x, y = thin_percent.y, w = 33*thin_percent.size, h = 25*thin_percent.size },
		color_key = {
			input = "#45cb65",
			output = secondary_col,
		},
    }),


	tall_pie_all = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
		dst = { x = tall_pie.x, y = tall_pie.y, w = 420*tall_pie.size, h = 423*tall_pie.size },
	}),
	tall_pie_entities = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
		dst = { x = tall_pie.x, y = tall_pie.y, w = 420*tall_pie.size, h = 423*tall_pie.size },
		color_key = {
			input = "#E446C4",
			output = secondary_col,
		},
	}),
    tall_pie_unspecified = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
		dst = { x = tall_pie.x, y = tall_pie.y, w = 420*tall_pie.size, h = 423*tall_pie.size },
		color_key = {
			input = "#46CE66",
			output = secondary_col,
		},
	}),
    tall_pie_blockentities = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
		dst = { x = tall_pie.x, y = tall_pie.y, w = 420*tall_pie.size, h = 423*tall_pie.size },
		color_key = {
			input = "#ec6e4e",
			output = primary_col,
		},
	}),
	tall_pie_destroyProgress = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
		dst = { x = tall_pie.x, y = tall_pie.y, w = 420*tall_pie.size, h = 423*tall_pie.size },
		color_key = {
			input = "#CC6C46",
			output = secondary_col,
		},
	}),
	tall_pie_prepare = make_mirror({
		src = { x = 44, y = 15978, w = 340, h = 178 },
		dst = { x = tall_pie.x, y = tall_pie.y, w = 420*tall_pie.size, h = 423*tall_pie.size },
		color_key = {
			input = "#464C46",
			output = secondary_col,
		},
	}),


	tall_percent_all = make_mirror({
		src = { x = 291, y = 16163, w = 33, h = 25 },
		dst = { x = tall_percent.x, y = tall_percent.y, w = 33*tall_percent.size, h = 25*tall_percent.size },
    }),
	tall_percent_blockentities = make_mirror({
		src = { x = 291, y = 16163, w = 33, h = 25 },
		dst = { x = tall_percent.x, y = tall_percent.y, w = 33*tall_percent.size, h = 25*tall_percent.size },
		color_key = {
			input = "#e96d4d",
			output = secondary_col,
		},
    }),
	tall_percent_unspecified = make_mirror({
		src = { x = 291, y = 16163, w = 33, h = 25 },
		dst = { x = tall_percent.x, y = tall_percent.y, w = 33*tall_percent.size, h = 25*tall_percent.size },
		color_key = {
			input = "#45cb65",
			output = secondary_col,
		},
    }),


	eye_measure = make_mirror({
		src = { x = 162, y = 7902, w = 60, h = 580 },
		dst = { x = 94, y = 470, w = 900, h = 500 },
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
		dst = { x = 94, y = 470, w = 900, h = 500 },
	}),
}


--*********************************************************************************************** MANAGING MIRRORS
local show_mirrors = function(eye, f3, tall, thin)

	images.measuring_overlay(eye)
	mirrors.eye_measure(eye)

	if e_count.enabled then
    	mirrors.e_counter(f3)
	end

	if thin_pie.enabled then
		-- mirrors.thin_pie_all(thin)
		mirrors.thin_pie_entities(thin)
		mirrors.thin_pie_unspecified(thin)
		mirrors.thin_pie_blockentities(thin)
		mirrors.thin_pie_destroyProgress(thin)
		mirrors.thin_pie_prepare(thin)
	end

	if thin_percent.enabled then
		-- mirrors.thin_percent_all(thin)
		mirrors.thin_percent_blockentities(thin)
		mirrors.thin_percent_unspecified(thin)
	end

	if tall_pie.enabled then
		-- mirrors.tall_pie_all(tall)
		mirrors.tall_pie_entities(tall)
		mirrors.tall_pie_unspecified(tall)
		mirrors.tall_pie_blockentities(tall)
		mirrors.tall_pie_destroyProgress(tall)
		mirrors.tall_pie_prepare(tall)
	end

	if tall_percent.enabled then
		-- mirrors.tall_percent_all(tall)
		mirrors.tall_percent_blockentities(tall)
		mirrors.tall_percent_unspecified(tall)
	end


end


--*********************************************************************************************** STATES
local thin_enable = function()
    show_mirrors(false, true, false, true)
end

local tall_enable = function()
	show_mirrors(true, true, true, false)
end
local wide_enable = function()
	show_mirrors(false, false, false, false)
end

local res_disable = function()
    show_mirrors(false, false, false, false)
end


--*********************************************************************************************** RESOLUTIONS
local make_res = function(width, height, enable, disable)
	return function()
		local active_width, active_height = waywall.active_res()

		if active_width == width and active_height == height then
			waywall.set_resolution(0, 0)
			disable()
		else
			waywall.set_resolution(width, height)
			enable()
		end
	end
end


local resolutions = {
	thin = make_res(350, 1100, thin_enable, res_disable),
	tall = make_res(384, 16384, tall_enable, res_disable),
	wide = make_res(2560, 400, wide_enable, res_disable),
}

local rebind_text = nil

--*********************************************************************************************** KEYBINDS
config.actions = {
	[thin_key] = function()
		resolutions.thin()
	end,

	[wide_key] = function()
		resolutions.wide()
	end,

	[tall_key] = function()
		resolutions.tall()
	end,

	[show_ninbot_key] = function()
		helpers.toggle_floating()
	end,

	[toggle_fullscreen_key] = waywall.toggle_fullscreen,

	[open_ninbot_key] = function()
		exec_ninb()
		-- exec_pacem()
	end,

}


return config