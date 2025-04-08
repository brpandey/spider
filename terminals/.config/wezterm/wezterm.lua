-- Load wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.exit_behavior = "Close"
config.color_scheme = "Galaxy"
-- config.color_scheme = "Nova (base16)"
config.font = wezterm.font("Fantasque Sans Mono")
-- config.font = wezterm.font("MesloLGS NF")

config.font_size = 12
config.line_height = 1.2

config.hide_tab_bar_if_only_one_tab = false
config.window_padding = {
	left = 4,
	right = 2,
	top = "0px",
	bottom = "0px",
}
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.7

-- config.keys = {
-- 	{
-- 		key = "n",
-- 		mods = "SHIFT|CTRL",
-- 		action = wezterm.action.ToggleFullScreen,
-- 	},
-- }

return config
