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
