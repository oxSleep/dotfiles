{ inputs, config, pkgs, lib, ... }:

{
    home.username = "oxv";
    home.homeDirectory = "/home/oxv";
    home.stateVersion = "24.11";
    home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
    home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.vanilla-dmz;
        name = "Vanilla-DMZ";
        size = 22;
    };
    home.packages = with pkgs; [ 
        gh
        gcc
        fzf 
        foot
        neovim
        wl-clipboard
        nwg-look
        xdg-ninja
        wofi
        waybar
        swww
        p7zip
        pwvucontrol
    ];

    home.preferXdgDirectories = true;
    xdg.enable = true;
    gtk = {
        enable = true;
        gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        theme = {
            package = pkgs.adw-gtk3;
            name = "adw-gtk3-dark";
        };

        iconTheme = {
            package = pkgs.adwaita-icon-theme;
            name = "Adwaita";
        };
    };
    programs.btop.enable = true;
    programs.git = {
        enable = true;
        userName  = "oxSleep";
        userEmail = "zw7vy1@protonmail.com";
    };
}
