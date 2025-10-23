# Waywall-generic-config

## Credits:
Thank you so much to @dariasc on discord for producing a config that slowly evolved into this config!

## Features:
- Configurable colors for mirrors and background
- Configurable ninbot position and opacity
- Toggleable mirrors for e-counter, pie chart, and percentages (for both thin and tall) (with toggleable color keys)
- Configurable hotkeys for resolution changes and ninjabrain bot visibility
- Toggleable and configurable keyboard remaps
- Coupled ninbot and paceman for easy setup

## Setup:
```bash
git clone https://github.com/arjuncgore/waywall_generic_config.git ~/.config/waywall
```
This clones this repository directly to your waywall config folder

## Configuration:
Just edit `remaps.lua` and the first few lines in `init.lua` for what you want, I'll probably make it easier to configure in the future tho.

## 1440p users read this!!!
If you're using a 1440p monitor, you'll definitely have to change the position of the mirrors, but here's a good place to start!
```lua
local e_count = 		{ enabled = true, x = 1500, y = 400, size = 7, colorkey = true} 
local thin_pie = 		{ enabled = true, x = 1490, y = 645, size = 3, colorkey = true} 
local thin_percent =	{ enabled = true, x = 1568, y = 1050, size = 8} 
local tall_pie = 		{ enabled = true, x = 1490, y = 645, size = 3, colorkey = true}
local tall_percent =	{ enabled = true, x = 1568, y = 1050, size = 8}
```
