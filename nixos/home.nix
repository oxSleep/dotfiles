{ inputs, config, pkgs, lib, ... }:

{
    nix.settings.use-xdg-base-directories = true;
    home.username = "oxv";
    home.homeDirectory = "/home/oxv";
    home.stateVersion = "24.11";
    home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];
    home.preferXdgDirectories = true;
    home.packages = with pkgs; [ 
        gh
        gcc
        fzf 
        foot
        neovim
        wl-clipboard
        pcmanfm
        nwg-look
        xdg-ninja
        wofi
        waybar
        swww
        duf
        p7zip
        pwvucontrol
    ];

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


    xdg.enable = true;
    programs.btop.enable = true;
    programs.git = {
        enable = true;
        userName  = "oxSleep";
        userEmail = "zw7vy1@protonmail.com";
    };
    systemd.user.startServices = "sd-switch";
}
