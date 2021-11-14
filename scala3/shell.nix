{ pkgs ? (import (import ./nix/sources.nix).nixpkgs { }) }:

with pkgs;

mkShell {
  name = "scala3";
  buildInputs = [
    dotty metals sbt scalafmt
  ];
}
