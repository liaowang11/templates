{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    zig.url = "github:arqv/zig-overlay";
  };

  outputs = { self, nixpkgs, utils, zig }:
    utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
          zigLatest = zig.packages."${system}".master.latest;
      in {

        # TDOO: default package and default app
        # defaultPackage = how to build zig?

        # defaultApp = utils.lib.mkApp { drv = self.defaultPackage."${system}"; };

        devShell = with pkgs;
          mkShell {
            name = zigLatest.meta.name;
            buildInputs = [ zigLatest ]; };
      });

}
