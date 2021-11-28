{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    let
      out = system:
        let pkgs = nixpkgs.legacyPackages."${system}";
        in {

          devShell = pkgs.mkShell {
            name = "racket";
            buildInputs = with pkgs; [ racket ];
          };

        };
    in with utils.lib; eachSystem defaultSystems out;
}
