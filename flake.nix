{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = { nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      mlir-tutorial-pkg = (pkgs.buildFHSUserEnv {
        name = "mlir-tutorial";
        targetPkgs = pkgs:
          [
            pkgs.bazel
            pkgs.glibc
            pkgs.gcc
            pkgs.clang
          ];
      }
      );
    in rec {
      defaultApp = flake-utils.lib.mkApp {
        drv = defaultPackage;
      };
      defaultPackage = mlir-tutorial-pkg;
      devShell = mlir-tutorial-pkg.env;
    }
  );
}
