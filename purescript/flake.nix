{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    easy-purescript-nix = {
      url = "github:justinwoo/easy-purescript-nix";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, easy-purescript-nix }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        easy-ps = import easy-purescript-nix { inherit pkgs; };
      in {

        # TDOO: default package and default app
        # defaultPackage = how to build zig?

        # defaultApp = utils.lib.mkApp { drv = self.defaultPackage."${system}"; };

        devShell = pkgs.mkShell {
          name = "purescript-${easy-ps.purs.version}";
          # Based on https://discourse.purescript.org/t/recommended-tooling-for-purescript-in-2021/2725
          buildInputs = with easy-ps; [
            pkgs.nodejs
            pkgs.nodePackages.eslint
            psa
            psc-package
            pscid
            purescript-language-server
            purs
            purs-tidy
            spago
            zephyr
          ];
        };
      });

}
