{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    zig.url = "github:arqv/zig-overlay";
    zls = {
      url = "https://github.com/zigtools/zls.git";
      type = "git";
      submodules = true;
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, zig, zls }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        zigLatest = zig.packages."${system}".master.latest;
        zlsPackage = pkgs.stdenvNoCC.mkDerivation {
          name = "zls";
          version = "master";
          src = zls;
          nativeBuildInputs = [ zigLatest ];
          dontConfigure = true;
          dontInstall = true;
          buildPhase = ''
            mkdir -p $out
            zig build install -Drelease-safe=true -Ddata_version=master --prefix $out
          '';
          XDG_CACHE_HOME = ".cache";
        };
      in {

        # TDOO: default package and default app
        # defaultPackage = how to build zig?

        # defaultApp = utils.lib.mkApp { drv = self.defaultPackage."${system}"; };

        devShell = pkgs.mkShell {
          name = zigLatest.meta.name;
          buildInputs = [ zigLatest zlsPackage ];
        };
      });

}
