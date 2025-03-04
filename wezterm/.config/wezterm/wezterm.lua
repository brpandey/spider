-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.exit_behavior = "Close"

config.color_scheme = "Galaxy"
-- config.color_scheme = "Nova (base16)"
-- config.colors = {
-- 	foreground = "#CBE0F0",
-- 	background = "#011423",
-- 	--  cursor_bg = "#47FF9C",
-- 	--	cursor_border = "#47FF9C",
-- 	cursor_bg = "white",
-- 	cursor_border = "white",
-- 	cursor_fg = "#011423",
-- 	selection_bg = "#033259",
-- 	selection_fg = "#CBE0F0",
-- 	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
-- 	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
-- }

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

-- and finally, return the configuration to wezterm
return config
