local wezterm = require("wezterm")
local config = wezterm.config_builder()

local isclean = wezterm.mux.get_active_workspace():lower():match("clean")

config.color_scheme = "Catppuccin Mocha"
config.use_fancy_tab_bar = true

if not isclean then
	config.hide_tab_bar_if_only_one_tab = false
else
	config.hide_tab_bar_if_only_one_tab = true
end

config.window_background_opacity = 0.95
config.initial_cols = 150
config.initial_rows = 40
config.enable_kitty_graphics = true

if not isclean then
	config.default_prog = { 'sh', '-c', 'fastfetch && echo && exec $SHELL' }
end

-- Tab bar colors
config.colors = config.colors or {}
config.colors.tab_bar = {
	background = "#1e1e2e",
	active_tab = {
		bg_color = "#1e1e2e",
		fg_color = "#f38ba8",
	},
	inactive_tab = {
		bg_color = "#1e1e2e",
		fg_color = "#b0b0b0",
	},
}

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
		key = "E",
		mods = "CTRL|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "O",
		mods = "CTRL|SHIFT",
		action = wezterm.action_callback(function(window, pane)
			local overrides = window:get_config_overrides() or {}
			if not overrides.window_background_opacity then
				overrides.window_background_opacity = 1.0
			else
				overrides.window_background_opacity = nil
			end
			window:set_config_overrides(overrides)
		end),
	},
	{ key = "d",         mods = "CTRL|SHIFT", action = act.ShowDebugOverlay },

	-- Delete entire word with Ctrl+Backspace
	{ key = "Backspace", mods = "CTRL",       action = act.SendKey({ key = "w", mods = "CTRL" }) },

	-- Cursor movement
	{ key = "i",         mods = "ALT",        action = act.SendKey({ key = "Home" }) }, -- Insert at beginning of line
	{ key = "a",         mods = "ALT",        action = act.SendKey({ key = "End" }) },  -- Insert at end of line

	-- Tab management
	{ key = "t",         mods = "ALT",        action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "b",         mods = "ALT",        action = act.SplitPane({ direction = "Down" }) },        -- Horizontal split (changed from 'h')
	{ key = "v",         mods = "ALT",        action = act.SplitPane({ direction = "Right" }) },       -- Vertical split
	{ key = "w",         mods = "ALT",        action = act.CloseCurrentPane({ confirm = false }) },
	{ key = "n",         mods = "ALT|SHIFT",  action = act.PaneSelect({ mode = "MoveToNewWindow" }) }, -- Move pane to new window

	-- Tab navigation
	{ key = "h",         mods = "ALT",        action = act.ActivateTabRelative(-1) },        -- Previous tab
	{ key = "l",         mods = "ALT",        action = act.ActivateTabRelative(1) },         -- Next tab
	{ key = "h",         mods = "ALT|SHIFT",  action = act.ActivatePaneDirection("Left") },  -- Tab to the left
	{ key = "l",         mods = "ALT|SHIFT",  action = act.ActivatePaneDirection("Right") }, -- Tab to the right
	{ key = "k",         mods = "ALT|SHIFT",  action = act.ActivatePaneDirection("Up") },    -- Tab above
	{ key = "j",         mods = "ALT|SHIFT",  action = act.ActivatePaneDirection("Down") },  -- Tab below
}


if isclean then
	local escape_count = 0
	local escape_timer = nil
	table.insert(config.keys, {
		key = "Escape",
		action = wezterm.action_callback(function(window, pane)
			escape_count = escape_count + 1
			if escape_timer then
				escape_timer:cancel()
			end
			escape_timer = wezterm.time.call_after(0.23, function()
				escape_count = 0
				escape_timer = nil
			end)
			if escape_count >= 2 then
				local prog = pane:get_foreground_process_info()
				local is_qalc = prog and prog.name and prog.name:match("qalc")

				window:perform_action(wezterm.action.SendKey { key = 'c', mods = 'CTRL' }, pane)
				wezterm.time.call_after(0.1, function()
					if is_qalc then
						window:perform_action(
							wezterm.action.SendString(
								'qalc -t "$(tail -1 ~/.config/qalculate/qalc.history)" | sed \'s/^[[:space:]]*//;s/[[:space:]]*$//;s/\\n//g\' | wl-copy\n'),
							pane)
						wezterm.time.call_after(0.2, function()
							window:perform_action(wezterm.action.CloseCurrentTab { confirm = false }, pane)
						end)
					else
						window:perform_action(wezterm.action.CloseCurrentTab { confirm = false }, pane)
					end
				end)
				escape_count = 0
				if escape_timer then
					escape_timer:cancel()
					escape_timer = nil
				end
			end
		end),
	})
end


if not isclean then
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

	wezterm.on('split-pane', function(window, pane)
		-- This event fires right AFTER the split occurs
		-- The 'pane' parameter is the newly created pane
		-- Send the clear command to the new pane with a slight delay
		-- to ensure the shell is ready
		wezterm.sleep_ms(100)
		pane:send_text('clear\r')
	end)
end

return config
