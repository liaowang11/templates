{
  description = "Scala3 environments";

  nixConfig.extra-experimental-features = "nix-command flakes ca-references";
  nixConfig.substituters =
    "https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ ];
        pkgs = import nixpkgs { inherit system overlays; };
      in {
        devShell = pkgs.mkShell {
          name = "scala3";
          buildInputs = with pkgs; [ dotty metals scalafmt (sbt.override { jre = jdk11;}) ];
        };
      });
}
