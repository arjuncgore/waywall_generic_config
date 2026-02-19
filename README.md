# Waywall-generic-config

## Features:
- Configurable colors for mirrors and background
- Configurable ninbot position and opacity
- Toggleable mirrors for E-counter, pie chart, and percentages (for both thin and tall resolutions), with optional color keying
- Configurable hotkeys for resolution changes and ninjabrain bot visibility
- Toggleable and configurable keyboard remaps
- Integrated Ninjabrain Bot and Paceman for easy setup
- Stretched and normal measuring overlays
- Compatible with Char's resize animations https://github.com/char3210/resize_animation/blob/main/resize_animation_waywall.py
- Support for resolution specific overlays for borders and more
- Optional automatic mouse [sensitivity](https://github.com/Esensats/mcsr-calcsens) switching for boat eye 

Please ask in #public-help in the linux mcsr discord server (linked in the guide) if you need any help configuring anything. You don't need to ping me specifically as most of the helpers know how to use this config. Please ping me if you find any bugs! (I don't typically respond to Discord DMs)

## Setup:
> IMPORTANT: If you already have a config that you wish to save, run this command to move it to waywall.bkp
```bash
mv ~/.config/waywall ~/.config/waywall.bkp
```
If you do not have an existing config, simply run:
```bash
git clone https://github.com/arjuncgore/waywall_generic_config.git ~/.config/waywall
```
This clones this repository directly to your waywall config folder

If you have a 1440p monitor, add this argument to the clone command `-b 1440`

## Configuration:
> IMPORTANT: Don't edit the code in `init.lua` unless you know what you're doing, you should only edit `config.lua` and `remaps.lua`
1. Looks
- You can set the colors for your background and mirrors
    - `text_col` impacts both the thin/tall percentages and e counter when colorkey is on
    - `pie_chart_1`, `pie_chart_2`, and `pie_chart_3` correspond to the orange, green, and purple sections respectively.
- Use a custom background image by replacing `resources/background.png` with your background of choice, and set `toggle_bg_picture` to true
- Use custom overlays over your resolutions (eg. borders) by replacing `resources/overlay_{thin, tall, wide}` with images of your choice
- Set your Ninjabrain Bot's position by anchoring it to a corner or edge and offsetting using the x and y values

2. Mirrors
- Turn mirrors on/off with the `enabled` option
- Set the position and size with `x`, `y`, and `size`
- Enable `colorkey` to hide the background, change your pie chart into a circle, and change the colors to the colors at the top of `config.lua`
- Use a stretched measuring window by enabling `stretched_measure`. Generate your own stretched overlay using [qMaxXen's overlay generator](https://qmaxxen.github.io/overlay-gen/more-options/) and set the Overlay width to 30. (be sure to rename it to `stretched_overlay.png` and replace the old one in `resources/`)

3. Keybinds
- Refer to [this](https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h) for your key's code, and [this](https://tesselslate.github.io/waywall/03_lookup_tables.html#modifiers) for any modifiers
- Having `*-` before a key allows the action to active while other keys are also pressed
- Choose whether resolution changes activate while F3 is held with `f3_safe` (useful if you set B or F to a hotkey, but you still need to toggle hitboxes or change render)
- Choose whether resolution changes activate while paused or in a menu with `ingame_only` (useful for search crafting with those keys)
- If you wish to not use a key, bind it to a key combo you won't press rather than deleting/commenting it out
- `toggle_ninbot_key` is how you can show/hide Ninjabrain Bot, the visibility option built in won't work in Waywall
- `toggle_remaps_key` enables chat mode and toggles your keyboard layout and remaps off and on

4. Keyboard
- Use the `xkb_config` options by setting `enabled` to true. You can disable any specific field by setting it to nil
- You can up any text you wish to show while in chat mode, and if you don't want any, change text to "" (I would recommend keeping some text so you know if you've accidentally turned your remaps and keyboard layout off)
- Set your remaps in `remaps_lua` in the `remapped_kb` table. Refer to [this](https://github.com/tesselslate/waywall/blob/main/include/util/keycodes.h) for the key codes for remaps
- Use the `normal_kb` table if you want any remaps to stay in chat mode, or leave it empty

5. Miscellaneous
- If you're using a 1440p monitor, make sure res_1440 is true. Make sure you change the positioning of the mirrors if you're transitioning from 1080p to 1440p or visa versa
- If you setup boat eye as per the [guide](https://its-saanvi.github.io/linux-mcsr/minecraft/wayland/boat-eye.html), set your waywall sens coefficients here
- If you wish to use Char's [Resize Animations](https://github.com/char3210/resize_animation/blob/main/resize_animation_waywall.py), set `enable_resize_animations` to true and follow the steps to setup OBS at the top of the python script.


## Demo Images:
### Original
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/e0fc27cb-965b-458f-be71-e3740d6d1575" />

<img width="1919" height="1080" alt="image" src="https://github.com/user-attachments/assets/4465d749-9452-4b0d-b148-ba0c0dd4a2b8" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/72194c85-7037-4750-8659-43071c36c49b" />


### With some configuration
<img width="2560" height="1440" alt="image" src="https://github.com/user-attachments/assets/571e1bfb-deb5-4233-a898-438a7b4a4580" />

<img width="2560" height="1440" alt="image" src="https://github.com/user-attachments/assets/68b9003b-befe-49e1-8f06-b0dbcf7d2648" />

<img width="2560" height="1440" alt="image" src="https://github.com/user-attachments/assets/583a471d-005f-4986-b593-2f9633e09254" />

## Credits:
Huge thanks to @dariasc on Discord for creating the original config that evolved into this project.