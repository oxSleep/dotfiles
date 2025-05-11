-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.default_cwd = "D:/0xV/Documents"
config.check_for_updates = false
config.set_environment_variables = {
    CLINK_INPUTRC = "D:/0xV/config/clink"
}

config.font = wezterm.font('IosevkaTerm NFM', { weight = 'Regular', italic = false })
config.font_size = 14.0

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.window_background_opacity = 0.95
config.colors = {
    -- Foreground and background
    foreground = "#deeeed", -- luster
    background = "#080808", -- gray1 (or use gray2 "#191919" for a slightly lighter background)

    -- Cursor colors
    cursor_bg = "#ffaa88", -- orange
    cursor_fg = "#deeeed", -- luster
    cursor_border = "#ffaa88", -- orange

    -- Selection colors
    selection_bg = "#555555", -- gray5
    selection_fg = "#deeeed", -- luster

    -- ANSI colors (normal)
    ansi = {
        "#000000", -- black
        "#D70000", -- red
        "#789978", -- green
        "#abab77", -- yellow
        "#7788AA", -- blue
        "#708090", -- lack (used as magenta for ANSI compatibility)
        "#aaaaaa", -- gray7 (cyan)
        "#cccccc", -- gray8 (white)
    },

    -- ANSI colors (bright)
    brights = {
        "#2a2a2a", -- gray3 (bright black)
        "#D70000", -- red (same as normal for consistency)
        "#789978", -- green
        "#abab77", -- yellow
        "#7788AA", -- blue
        "#708090", -- lack (magenta)
        "#aaaaaa", -- gray7 (cyan)
        "#DDDDDD", -- gray9 (bright white)
    },

    -- Tab bar colors
    tab_bar = {
        background = "#080808", -- gray1
        active_tab = {
            bg_color = "#2a2a2a", -- gray3
            fg_color = "#deeeed", -- luster
            intensity = "Normal",
            underline = "None",
            italic = false,
            strikethrough = false,
        },
        inactive_tab = {
            bg_color = "#080808", -- gray1
            fg_color = "#7a7a7a", -- gray6
        },
        inactive_tab_hover = {
            bg_color = "#191919", -- gray2
            fg_color = "#cccccc", -- gray8
            italic = false,
        },
        new_tab = {
            bg_color = "#080808", -- gray1
            fg_color = "#7a7a7a", -- gray6
        },
        new_tab_hover = {
            bg_color = "#191919", -- gray2
            fg_color = "#cccccc", -- gray8
            italic = false,
        },
    },
}

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {}

-- Custom tab bar formatting: show only program name
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local program = tab.active_pane.foreground_process_name
    -- Extract just the program name (e.g., "bash" from "/bin/bash")
    local title = program:match("[\\/]([^\\/]+)$") or program
    local index = tab.tab_index + 1
    local icon = tab.is_active and "●" or "○"
    return {
        { Text = " " .. icon .. " " .. index .. ": " .. title .. " " },
    }
end)

-- Status bar
wezterm.on("update-right-status", function(window, pane)
    local date = wezterm.strftime "%Y-%m-%d %H:%M:%S"
    local workspace = window:active_workspace()
    window:set_right_status(wezterm.format {
        { Foreground = { Color = "#deeeed" } }, -- luster
        { Background = { Color = "#080808" } }, -- gray1
        { Text = " " .. workspace .. " | " .. date .. " " },
    })
end)

-- and finally, return the configuration to wezterm
return config
