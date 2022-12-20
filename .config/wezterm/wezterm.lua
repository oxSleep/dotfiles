local wezterm = require 'wezterm'


return {

    font = wezterm.font( "CaskaydiaCove Nerd Font Mono", { weight = "Regular"} ),
    enable_wayland = true,
    window_background_opacity = 0.85,
    color_scheme = "Poimandres",
    window_padding = {
        left = 25,
        right = 25,
        top = 10,
        bottom = 0,
    },

    -- tab bar
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    hide_tab_bar_if_only_one_tab = true,
    tab_max_width = 999999,
    	window_decorations = "RESIZE",

    unix_domains = {
        {
            name = 'unix',
        },
    },

    -- This causes `wezterm` to act as though it was started as
    -- `wezterm connect unix` by default, connecting to the unix
    -- domain on startup.
    -- If you prefer to connect manually, leave out this line.
    -- default_gui_startup_args = { 'connect', 'unix' },
}
