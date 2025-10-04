# Waywall-generic-config

**Generic Waywall Config (1080p or 1440p)**

Features:
- Configurable colors for mirrors and background
- Background image placeholder
- Configurable ninbot position and opacity
- Toggleable mirrors for e-counter, pie-chart, and percentages (for both thin and tall)
- Configurable hotkeys for resolution changes and ninjabrain bot visibility
- Configurable keyboard remaps
- Toggleable remaps
- Coupled ninbot and paceman

Setup:
```git clone https://github.com/arjuncgore/waywall_generic_config.git ~/.config/waywall```

(clones this repository to your waywall config folder)




use these values as a default for 1440p
```lua
local e_count = 		{ enabled = true, x = 1500, y = 400, size = 7} 
local thin_pie = 		{ enabled = true, x = 1490, y = 645, size = 1} 
local thin_percent =	{ enabled = true, x = 1568, y = 1050, size = 8} 
local tall_pie = 		{ enabled = true, x = 1490, y = 645, size = 1} -- Leave same as thin for seamlessness
local tall_percent =	{ enabled = true, x = 1568, y = 1050, size = 8} -- Leave same as thin for seamlessness
```
