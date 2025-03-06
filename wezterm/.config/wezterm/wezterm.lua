-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.exit_behavior = "Close"

config.color_scheme = "Galaxy"
-- config.color_scheme = "Nova (base16)"
-- config.font = wezterm.font("Fantasque Sans Mono")

config.font = wezterm.font("MesloLGS NF")
config.font_size = 11

config.line_height = 1.2

config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 4,
	right = 2,
	top = "0px",
	bottom = "0px",
}
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.9
config.macos_window_background_blur = 10

config.keys = {
	{
		key = "n",
		mods = "SHIFT|CTRL",
		action = wezterm.action.ToggleFullScreen,
	},
}

-- and finally, return the configuration to wezterm
return config
