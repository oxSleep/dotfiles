{ inputs, config, lib, pkgs, ... }:
{
    imports = [ 
        ./hardware-configuration.nix
        inputs.home-manager.nixosModules.home-manager
    ];

    home-manager.useUserPackages = true;
    home-manager.useGlobalPkgs = true;
    home-manager.backupFileExtension = "bkp";
    home-manager.users.oxv = import ./home.nix;

    users.users.oxv= {
        isNormalUser = true;
        extraGroups = [ "wheel" "audio" "video" "input" ]; # Enable ‘sudo’ for the user.
    };

    nix = {
        settings = {
            use-xdg-base-directories = true;
            experimental-features = [ "nix-command" "flakes" ];
        };
    };

    nixpkgs.config.allowUnfree = true; 
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = false;
        dedicatedServer.openFirewall = false;
        localNetworkGameTransfers.openFirewall = false;
    };
    programs.hyprland.enable = true;
    programs.adb.enable = true;

    environment = {
        sessionVariables.NIX_OS_OZONE_WL = "1";
        systemPackages = with pkgs; [
                keepassxc
                neovim
                dnscrypt-proxy
                wget
                curl
                brave
                xdg-desktop-portal-gtk
                hyprpolkitagent
        ];
    };

    nix = {
        optimise = {
            automatic = true;
            dates = [ "weekly" ];
        };
        settings = {
            auto-optimise-store = true;
        };
    };

    services.dnscrypt-proxy2.enable = true;
    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    time.timeZone = "Europe/Paris";
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "void";
    systemd.network.networks."enp8s0" = {
        matchConfig.Name = "lan";
        networkConfig.DHCP = "ipv4";
    };

    system.stateVersion = "24.11"; # Did you read the comment?
}
