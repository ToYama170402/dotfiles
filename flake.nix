{
  description = "Home Manager configuration of toyama";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:guibou/nixGL";
    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixgl,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
        overlays = [
          nixgl.overlay
        ];
      };
    in
    {
      homeConfigurations."${builtins.getEnv "USER"}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = {
          inputs = {
            inherit nixpkgs;
            inherit home-manager;
            inherit nixgl;
            inherit nixvim;
          };
        };

        # Optionally use extraSpecialArgs>
        # to pass through arguments to home.nix

      };
    };
}
