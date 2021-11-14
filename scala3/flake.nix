{
  description = "Scala3 environments";

  nixConfig.extra-experimental-features = "nix-command flakes ca-references";
  nixConfig.substituters = "https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.devshell.url = "github:numtide/devshell";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, flake-utils, devshell, nixpkgs }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShell =
        let pkgs = import nixpkgs {
          inherit system;

          overlays = [ devshell.overlay ];
        };
        in
        pkgs.devshell.mkShell {
          name = "scala";
          imports = [ (pkgs.devshell.importTOML ./devshell.toml) ];
        };
    });
}
