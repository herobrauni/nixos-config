{
  description = "brauni NixOS Flake";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [
      "https://cache.nixos.org"
      "https://anyrun.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nixpkgs-wayland.cachix.org"
    ];

    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };    

    inputs = {
    # Official NixOS package source, using nixos-unstable branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # modern window compositor
    hyprland.url = "github:hyprwm/Hyprland/v0.25.0";
    # community wayland nixpkgs
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # file persistance
    impermanence.url = "github:nix-community/impermanence";

    # secure boot
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{
      self,
      nixpkgs,
      lanzaboote,
      home-manager,
      ...
  }: {
    nixosConfigurations = {
      "nixosdesk" = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          pkgs-stable = import inputs.nixpkgs-stable {
            system = system;  # refer the `system` parameter form outer scope recursively
            # To use chrome, we need to allow the installation of non-free software
            config.allowUnfree = true;
          };
        } // inputs;
        modules = [
          ./hosts/desktop

          inputs.impermanence.nixosModules.impermanence

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # pass all inputs into home manager's all sub modules
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.users.brauni = import ./home/brauni.nix;
          }

          lanzaboote.nixosModules.lanzaboote
          ({ pkgs, lib, ... }: {
            environment.systemPackages = [
              # For debugging and troubleshooting Secure Boot.
              pkgs.sbctl
            ];
            boot.loader.systemd-boot.enable = lib.mkForce false;

            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/etc/secureboot";
            };
          })
        ];
      };
    };
  };
}
