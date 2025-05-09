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
    xdg.enable = true;
    home.preferXdgDirectories = true;

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
    programs.home-manager.enable = true;
    programs.btop.enable = true;
    programs.git = {
        enable = true;
        userName  = "oxSleep";
        userEmail = "zw7vy1@protonmail.com";
    };
    programs.foot = {
        enable = true;
        settings = {
            main = {
                font = "Iosevka NFM:size=14";
            };
            cursor = {
                style = "block";
                blink = true;
            };
            colors = {
                foreground = "DEEEED";
                background = "0A0A0A";
                regular0 = "080808";
                regular1 = "D70000";
                regular2 = "789978";
                regular3 = "FFAA88";
                regular4 = "7788AA";
                regular5 = "D7007D";
                regular6 = "708090";
                regular7 = "DEEEED";
                bright0 = "444444";
                bright1 = "D70000";
                bright2 = "789978";
                bright3 = "FFAA88";
                bright4 = "7788AA";
                bright5 = "D7007D";
                bright6 = "708090";
                bright7 = "DEEEED";
                selection-foreground = "DEEEED";
                selection-background = "7A7A7A";
                urls = "D7007D";
                alpha = 0.9;
            };
        };
    };
}
