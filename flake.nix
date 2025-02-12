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
            bat
            gum
            yq
          ];
          text = ''
            DEST="''${1:-.}"
            mkdir -p "$DEST"
            (
              printf "Will create the Lean4 project inside the directory:\n"
              printf "* \`%s\`" "$(realpath "$DEST")"
            ) | bat -f -l md --style=grid
            copier copy --vcs-ref=HEAD gh:provables/lean4-template "$DEST"
            rm -rf "$DEST"/flake.*
            PROJ_NAME=$(yq -r '.project_name' < "$DEST"/.copier-answers.yml)
            GITDIR="$DEST/$PROJ_NAME"
            (
              printf "Will initialize \`git\` in \`%s\`,\n" "$GITDIR"
              printf "and will add the generated project."
            ) | bat -f -l md --style=grid
            gum confirm "Continue?" || exit 1
            cd "$GITDIR"
            git init -b main
            git add .
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
