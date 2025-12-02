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
- Stretched and normal measuring overlays
- Compatible with Char's resize animations https://github.com/char3210/resize_animation/blob/main/resize_animation_waywall.py
- Support for resolution specific overlays for borders and more
- Support for auto changing mouse sensitivity https://github.com/Esensats/mcsr-calcsens

## Setup:
IMPORTANT: If you already have a config that you wish to save, run this command to move it to waywall.bkp
```bash
mv ~/.config/waywall ~/.config/waywall.bkp
```
Then or otherwise
```bash
git clone https://github.com/arjuncgore/waywall_generic_config.git ~/.config/waywall
```
This clones this repository directly to your waywall config folder

If you have a 1440p monitor, add this argument to the clone command `-b 1440`

## Configuration:
Just edit `remaps.lua` and the first few lines in `config.lua` for what you want. Might add a minor guide here later but it's fairly self-explanatory.

Use this link with an overlay width of 30 to create your own stretched overlay https://qmaxxen.github.io/overlay-gen/more-options/

## Demo Images:
### Original
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e0fc27cb-965b-458f-be71-e3740d6d1575" />

<img width="1919" height="1080" alt="image" src="https://github.com/user-attachments/assets/4465d749-9452-4b0d-b148-ba0c0dd4a2b8" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/72194c85-7037-4750-8659-43071c36c49b" />


### With some configuration
<img width="2560" height="1440" alt="image" src="https://github.com/user-attachments/assets/571e1bfb-deb5-4233-a898-438a7b4a4580" />

<img width="2560" height="1440" alt="image" src="https://github.com/user-attachments/assets/68b9003b-befe-49e1-8f06-b0dbcf7d2648" />

<img width="2560" height="1440" alt="image" src="https://github.com/user-attachments/assets/583a471d-005f-4986-b593-2f9633e09254" />
