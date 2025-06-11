{
  description = "bphenriques's retro-handhelds";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs @ { nixpkgs, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
    in {
      devShells = forAllSystems (system: {
        default = import ./shell.nix { pkgs = nixpkgs.legacyPackages.${system}; };
      });
    };
}
