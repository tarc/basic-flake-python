# Build custom python environment

## `mach-nix`

- Github repository: [DavHau/mach-nix][githubMatchNix];
- Git commit: [`913e6c16f986746ba5507878ef7ff992804d1fa8`][matchNixRef];
- On: Nov 8, 2022;
- Last commit on `master` branch before project goes officially unmaintained.

[githubMatchNix]: https://github.com/DavHau/mach-nix
[matchNixRef]: https://github.com/DavHau/mach-nix/commits/913e6c16f986746ba5507878ef7ff992804d1fa8

## `pypi-deps-db`

- Github repository: [DavHau/pypi-deps-db][githubPypiDepsDb];
- Git commit: [`91adfffe522d3571e6549c77695adaa5ef3fecc5`][pypiDepsDbRef]:
- On: Jan 12, 2023.

[githubPypiDepsDb]: https://github.com/DavHau/pypi-deps-db
[pypiDepsDbRef]: https://github.com/DavHau/pypi-deps-db/commits/91adfffe522d3571e6549c77695adaa5ef3fecc5

## Start shell

```bash
nix -v --accept-flake-config --show-trace develop
```

## Push do Cachix

```bash
 nix -v --accept-flake-config --show-trace develop --profile conan-dev-profile
 cachix push tarc conan-dev-profile
```
