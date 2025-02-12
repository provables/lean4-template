{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        app = pkgs.writeShellApplication {
          name = "copier";
          runtimeInputs = with pkgs; [
            copier
            git
          ];
          text = ''
            copier copy gh:provables/lean4-template .
          '';
        };
      in
      {
        apps.default = {
          type = "app";
          program = "${app}/bin/copier";
        };
      }
    );
}
