{
  description = "Home Manager configuration of toyama";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:guibou/nixGL";
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    nix-beutl.url = "github:ToYama170402/nix-beutl";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixgl,
      nixvim,
      nix-beutl,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = system;
        config.allowUnfree = true;
        overlays = [
          nixgl.overlay
          (final: prev: {
            beutl = nix-beutl.packages.${system}.default;
          })
        ];
      };
    in
    {
      homeConfigurations."${builtins.getEnv "USER"}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };

      formatter."${system}" = pkgs.nixfmt;
    };
}
