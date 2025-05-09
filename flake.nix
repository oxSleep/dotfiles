{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... } @ inputs: 
    let
        inherit (self) outputs;
    in
    {
        nixosConfigurations = {
            system = "x86_64-linux";
            void = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs outputs; };
                modules = [ ./nixos/configuration.nix ];
            };
        };
    };
}
