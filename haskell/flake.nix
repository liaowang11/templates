{
  description = "haskell template";

  nixConfig.extra-experimental-features = "nix-command flakes ca-references";
  nixConfig.substituters = "https://mirrors.ustc.edu.cn/nix-channels/store https://cache.nixos.org/";

  inputs.devshell.url = "github:numtide/devshell";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-compat = {
    url = "github:edolstra/flake-compat";
    flake = false;
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, devshell, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs =
          import nixpkgs {
            inherit system;
            overlays = [ devshell.overlay ];
          };
        project = returnShellEnv:
          pkgs.haskellPackages.developPackage {
            inherit returnShellEnv;
            name = "haskell-template";
            root = ./.;
            withHoogle = true;
            overrides = self: super: with pkgs.haskell.lib; {
              # Use callCabal2nix to override Haskell dependencies here
              # cf. https://tek.brick.do/K3VXJd8mEKO7
            };
            modifier = drv:
              pkgs.haskell.lib.addBuildTools drv (with pkgs.haskellPackages;
              [
                # Specify your build/dev dependencies here.
                cabal-fmt
                cabal-install
                ghcid
                haskell-language-server
                hlint
                hp2pretty
                ormolu
                pkgs.nixpkgs-fmt
              ]);
          };
      in
      {
        # Used by `nix build` & `nix run` (prod exe)
        defaultPackage = project false;

        # Used by `nix develop` (dev shell)
        devShell = project true;
      });
}
