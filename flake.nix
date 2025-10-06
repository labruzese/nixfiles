{
  description = "skylar's nix on arch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHome = modules: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ] ++ modules;
      };
    in
    {
      homeConfigurations = {
        "sky@skylar-desktop" = mkHome [ ./machines/desktop/home.nix ];
        "sky@skylar-laptop" = mkHome [ ./machines/laptop/home.nix ];
      };
    };
}
