{ config, pkgs, lib, ... }:

{

	home-manager.useUserPackages = true;
	home-manager.useGlobalPkgs = true;
	home-manager.backupFileExtension = "bkp";
	home-manager.users.oxv = import ./home.nix;
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

    programs.btop.enable = true;
    programs.git = {
        enable = true;
        userName  = "oxSleep";
        userEmail = "zw7vy1@protonmail.com";
    };

    home.file.".bash_profile".text = ''
. "${config.home.homeDirectory}/.nix-profile/etc/profile.d/hm-session-vars.sh"
[[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"
	    '';

    home.file.".bashrc".text = ''
export HISTFILE="${config.xdg.stateHome}/bash/bash_history"
export HISTSIZE=10000
alias nrs='sudo nixos-rebuild switch'
alias ls='ls --color=auto --group-directories-first'
alias la='ls -la --color=auto'
alias grep='grep --color=auto'
alias adb='$HOME="${config.xdg.dataHome}/android" adb'

PS1='[\[\e[32m\]\u\[\e[0m\]@\[\e[35m\]\h\[\e[0m\]][\[\e[38;5;69m\]\w\[\e[0m\]]\$ '
	    '';


    home.file."${config.xdg.configHome}/readline/inputrc".text = ''
set completion-ignore-case on
set mark-symlinked-directories on
set bell-style none
set show-all-if-ambiguous on

"\C-p": history-search-backward
"\C-n": history-search-forward
	    '';

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
