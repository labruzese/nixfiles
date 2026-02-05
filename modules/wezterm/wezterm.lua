local wezterm = require("wezterm")
local config = wezterm.config_builder()
local isclean = wezterm.mux.get_active_workspace():lower():match("clean")

config.color_scheme = active_scheme -- will get defined by wezterm.nix
config.use_fancy_tab_bar = true

--this will get overridden if we proceed past the clean config wall
config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.95
config.initial_cols = 150
config.initial_rows = 40
config.enable_kitty_graphics = true


-- Tab bar colors
config.colors = config.colors or {}
-- config.colors.tab_bar = {
-- 	background = "#1e1e2e",
-- 	active_tab = {
-- 		bg_color = "#1e1e2e",
-- 		fg_color = "#f38ba8",
-- 	},
-- 	inactive_tab = {
-- 		bg_color = "#1e1e2e",
-- 		fg_color = "#b0b0b0",
-- 	},
-- }

-- Keybindings
local act = wezterm.action

config.mouse_bindings = {
	{
		event = { Down = { streak = 3, button = 'Left' } },
		action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
		mods = 'NONE',
	},
}

config.keys = {
	{
		key = "n",
		mods = "ALT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "o",
		mods = "ALT",
		action = wezterm.action_callback(function(window, _)
			local overrides = window:get_config_overrides() or {}
			if not overrides.window_background_opacity then
				overrides.window_background_opacity = 1.0
			else
				overrides.window_background_opacity = nil
			end
			window:set_config_overrides(overrides)
		end),
	},
	{ key = "d",         mods = "ALT",       action = act.ShowDebugOverlay },

	-- Delete entire word with Ctrl+Backspace
	{ key = "Backspace", mods = "CTRL",      action = act.SendKey({ key = "w", mods = "CTRL" }) },

	-- Session Management Keybinds
	{ key = "t",         mods = "ALT",       action = act.SpawnTab("CurrentPaneDomain") },

	-- Switch to specific tabs in default workspace (Alt + q/w/e/r)
	{ key = "q",         mods = "ALT",       action = act.ActivateTab(0) },
	{ key = "w",         mods = "ALT",       action = act.ActivateTab(1) },
	{ key = "e",         mods = "ALT",       action = act.ActivateTab(2) },
	{ key = "r",         mods = "ALT",       action = act.ActivateTab(3) },

	-- Switch to specific tabs in alternate workspace (Alt + z/x)
	{ key = "z",         mods = "ALT",       action = act.ActivateTab(0) },
	{ key = "x",         mods = "ALT",       action = act.ActivateTab(1) },

	-- Move focus between panes (Alt + h/j/k/l)
	{ key = "h",         mods = "ALT",       action = act.ActivatePaneDirection("Left") },
	{ key = "j",         mods = "ALT",       action = act.ActivatePaneDirection("Down") },
	{ key = "k",         mods = "ALT",       action = act.ActivatePaneDirection("Up") },
	{ key = "l",         mods = "ALT",       action = act.ActivatePaneDirection("Right") },

	-- Workspace management (Alt + 1 for default, Alt + 2 for alternate)
	{ key = "1",         mods = "ALT",       action = act.SwitchToWorkspace({ name = "default" }) },
	{ key = "2",         mods = "ALT",       action = act.SwitchToWorkspace({ name = "alternate" }) },

	-- Workspace switcher (Alt + s shows all workspaces)
	{ key = "s",         mods = "ALT",       action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },


	-- Open new pane in current tab (Alt + Enter)
	{ key = "Return",    mods = "ALT",       action = act.SplitPane({ direction = "Right" }) },
	{ key = "Return",    mods = "ALT|SHIFT", action = act.SplitPane({ direction = "Down" }) },

	-- Close current pane (Alt + c)
	{ key = "c",         mods = "ALT",       action = act.CloseCurrentPane({ confirm = false }) },

	-- Toggle fullscreen (Alt + f)
	{ key = "f",         mods = "ALT",       action = act.TogglePaneZoomState },

	-- Move current pane to specific tabs (Alt + Shift + q/w/e/r/t/z/x)
	{ key = "Q",         mods = "ALT|SHIFT", action = act.MoveTab(0) },
	{ key = "W",         mods = "ALT|SHIFT", action = act.MoveTab(1) },
	{ key = "E",         mods = "ALT|SHIFT", action = act.MoveTab(2) },
	{ key = "R",         mods = "ALT|SHIFT", action = act.MoveTab(3) },
	{ key = "T",         mods = "ALT|SHIFT", action = act.MoveTab(4) },
	{ key = "Z",         mods = "ALT|SHIFT", action = act.MoveTab(5) },
	{ key = "X",         mods = "ALT|SHIFT", action = act.MoveTab(6) },
}

-- don't run the rest of setup in clean mode
if isclean then
	return config
end

-- config.default_prog = { 'sh', '-c', 'fastfetch && echo && exec $SHELL' }
config.hide_tab_bar_if_only_one_tab = false

-- Load the bar plugin upfront instead of asynchronously
local bar = wezterm.plugin.require("https://github.com/labruzese/bar.wezterm")

bar.apply_to_config(config, {
	position = "bottom",
	max_width = 32,
	padding = {
		left = 1,
		right = 1,
	},
	separator = {
		space = 1,
		left_icon = wezterm.nerdfonts.fa_long_arrow_right,
		right_icon = wezterm.nerdfonts.fa_long_arrow_left,
		field_icon = wezterm.nerdfonts.indent_line,
	},
	modules = {
		hostname = {
			color = 2,
		},
		spotify = {
			enabled = false,
			color = 3,
			max_width = 64,
			throttle = 15,
		},
	},
})

wezterm.on('split-pane', function(_, pane)
	-- This event fires right AFTER the split occurs
	-- The 'pane' parameter is the newly created pane
	-- Send the clear command to the new pane with a slight delay
	-- to ensure the shell is ready
	wezterm.sleep_ms(100)
	pane:send_text('clear\r')
end)

return config
