local wezterm = require 'wezterm'
local act = wezterm.action
local config={}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font=wezterm.font("monospace")
config.font_size=14
config.use_ime=true
config.color_scheme="Solarized (dark) (terminal.sexy)"
config.selection_word_boundary = " \t\n{}[]()\"'`,;:│=&!%"
config.use_fancy_tab_bar=false
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false
config.animation_fps = 1
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

config.keys = {
  {
    key = '/',
    mods = 'ALT',
    action = act.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

	{ key = "=", mods = "ALT", action = "ResetFontSize" },
	{ key = "+", mods = "CTRL|SHIFT", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL|SHIFT", action = "DecreaseFontSize" },
  { key = "-", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "\\", mods = "ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
}
config.key_tables = {
  resize_pane = {
    { key = 'LeftArrow', action = act.AdjustPaneSize { 'Left', 1 } },
    { key = 'h', action = act.AdjustPaneSize { 'Left', 1 } },

    { key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { key = 'l', action = act.AdjustPaneSize { 'Right', 1 } },

    { key = 'UpArrow', action = act.AdjustPaneSize { 'Up', 1 } },
    { key = 'k', action = act.AdjustPaneSize { 'Up', 1 } },

    { key = 'DownArrow', action = act.AdjustPaneSize { 'Down', 1 } },
    { key = 'j', action = act.AdjustPaneSize { 'Down', 1 } },

    { key = 'LeftArrow', mods = "SHIFT", action = act.ActivatePaneDirection 'Left' },
    { key = 'h',mods = "SHIFT", action = act.ActivatePaneDirection 'Left' },

    { key = 'RightArrow',mods = "SHIFT", action = act.ActivatePaneDirection 'Right' },
    { key = 'l',mods = "SHIFT", action = act.ActivatePaneDirection 'Right' },

    { key = 'UpArrow',mods = "SHIFT", action = act.ActivatePaneDirection 'Up' },
    { key = 'k',mods = "SHIFT", action = act.ActivatePaneDirection 'Up' },

    { key = 'DownArrow',mods = "SHIFT", action = act.ActivatePaneDirection 'Down' },
    { key = 'j',mods = "SHIFT", action = act.ActivatePaneDirection 'Down' },

    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter', action = 'PopKeyTable' },
  },
}


wezterm.on("update-right-status", function(window, pane)
	local cwd = " "..pane:get_current_working_dir():sub(8).." "; -- remove file:// uri prefix
	local date = wezterm.strftime(" %H:%M:%S  %Y/%m/%d ");
	local hostname = " "..wezterm.hostname().." ";
	local name = window:active_key_table()
	if name then
		name = "Mode: " .. name
  else
    name =""
	end
	window:set_right_status(
		wezterm.format({
			{Foreground={Color="#ffffff"}},
			{Background={Color="#00875f"}},
			{Text=name},
		})..
		wezterm.format({
			{Foreground={Color="#ffffff"}},
			{Background={Color="#005f5f"}},
			{Text=cwd},
		})..
		wezterm.format({
			{Foreground={Color="#00875f"}},
			{Background={Color="#005f5f"}},
			{Text=""},
		})..
		wezterm.format({
			{Foreground={Color="#ffffff"}},
			{Background={Color="#00875f"}},
			{Text=date},
		})..
		wezterm.format({
			{Foreground={Color="#00af87"}},
			{Background={Color="#00875f"}},
			{Text=""},
		})..
		wezterm.format({
			{Foreground={Color="#ffffff"}},
			{Background={Color="#00af87"}},
			{Text=hostname},
		})
	);
end);
return config
