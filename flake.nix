{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    xremap.url = "github:xremap/nix-flake";
  };

  outputs = inputs: {
    nixosConfigurations = {
      su8ruX1C7 = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nix/configuration.nix
        ];
        specialArgs = {
          inherit inputs;
        };
      };
    };
  };
}

