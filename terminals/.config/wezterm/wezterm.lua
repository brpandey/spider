local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.exit_behavior = "Close"
config.color_scheme = "Galaxy"
config.font = wezterm.font("Fantasque Sans Mono")
config.font_size = 13

-- safer than 1.2 on Wayland
config.line_height = 1.0

-- keep padding EVEN numbers (important!)
config.window_padding = {
	left = 4,
	right = 4,
	top = 2,
	bottom = 2,
}

-- safest on Wayland
config.window_decorations = "NONE"

-- you can try turning this back on later
config.window_background_opacity = 0.7

config.hide_tab_bar_if_only_one_tab = false

return config
