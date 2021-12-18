{ pkgs ? import <nixpkgs> { } }:
let
  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "13ace3addf14dd9e93af9132e4799b7badfbe99e";
    sha256 = "sha256-thMMJPmtk7tZKFjBg6HzcJcgPTNvixSThfJ5P0cIar8=";
  }) { inherit pkgs; };
in (pkgs.mkShell {
  buildInputs = with easy-ps; [
    purs-0_14_5
    purs-tidy
    psc-package
    spago
    purescript-language-server
    pscid
    pulp
    purty
    pkgs.nodejs
  ];
}).overrideAttrs (oldAttrs: { name = "easy-purescript-nix"; })
