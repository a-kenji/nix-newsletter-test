{
  pkgs ? import <nixpkgs> { },
}:
pkgs.buildNpmPackage {
  pname = "nix-newsletter-test";
  version = "0.1.0";
  src = ./.;

  npmDeps = pkgs.importNpmLock {
    npmRoot = ./.;
  };

  installPhase = ''
    ls -la .
    mkdir -p $out
    cp -r . $out
  '';

  npmConfigHook = pkgs.importNpmLock.npmConfigHook;
}
