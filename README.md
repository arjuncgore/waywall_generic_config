# Waywall-generic-config

**Generic Waywall Config (1080p or 1440p)**

Features:
- Configurable colors for mirrors and background
- Configurable ninbot position and opacity
- Toggleable mirrors for e-counter, pie-chart, and percentages (for both thin and tall)
- Configurable hotkeys for resolution changes and ninjabrain bot visibility
- Configurable keyboard remaps

Setup: (the bash commands may not work)
- Download the appropriate config file and rename it to `init.lua` ```mv ~/Downloads/init_1080.lua ~/Downloads/init.lua```
- Either use your own measuring overlay, or download the one provided here
- Make a folder titled `waywall` in the `~/.config` directory ```mkdir -p ~/.config/waywall```
- Place `init.lua` and `measuring_overlay.png` in that folder ```mv ~/Downloads/init.lua ~/Downloads/measuring_overlay.png ~/.config/waywall```
- Edit the `<username>` in `nb_path` and `overlay_path` in `init.lua` to your pc's username (lines 9, 10)

let me (or anyone else) know if you need any help


use these values as a default for 1440p
```lua
local e_count = 		{ enabled = true, x = 1500, y = 400, size = 7} 
local thin_pie = 		{ enabled = true, x = 1490, y = 645, size = 1} 
local thin_percent =	{ enabled = true, x = 1568, y = 1050, size = 8} 
local tall_pie = 		{ enabled = true, x = 1490, y = 645, size = 1} -- Leave same as thin for seamlessness
local tall_percent =	{ enabled = true, x = 1568, y = 1050, size = 8} -- Leave same as thin for seamlessness
```