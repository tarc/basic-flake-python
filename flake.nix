{
  description = "A very basic flake";

  nixConfig = {
    substituters = ["https://cache.nixos.org" "https://kclejeune.cachix.org" "https://tarc.cachix.org"];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "kclejeune.cachix.org-1:fOCrECygdFZKbMxHClhiTS6oowOkJ/I/dh9q9b1I4ko="
      "tarc.cachix.org-1:wIYVNrWvfOFESyas4plhMmGv91TjiTBVWB0oqf1fHcE="
    ];

    extra-experimental-features = "nix-command flakes";
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/22.05";
    flake-utils.url = "github:numtide/flake-utils";

    # This section will allow us to create a python environment
    # with specific predefined python packages from PyPi
    mach-nix = {
      url = "mach-nix/913e6c16f986746ba5507878ef7ff992804d1fa8";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.pypi-deps-db.follows = "pypi-deps-db";

    };
    pypi-deps-db = {
      url = "github:DavHau/pypi-deps-db?rev=91adfffe522d3571e6549c77695adaa5ef3fecc5";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.mach-nix.follows = "mach-nix";
    };
  };

  outputs = { self, nixpkgs, flake-utils, mach-nix, pypi-deps-db, ... }@attr:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
      mach-nix_ = (import mach-nix) {
        inherit pkgs;
        pypiDataRev = pypi-deps-db.rev;
        pypiDataSha256 = pypi-deps-db.narHash;
        python = "python310";
      };

      # create a custom python environment
      myPython = mach-nix_.mkPython ({
        # With custom packages
        requirements = ''
          conan
        '';
      });
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [
          # Now you can use your custom python environemt!
          # This should also work for `buildInputs` and so on!
          myPython
        ];
      };
    }
  );
}
