{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    clan.url = "git+https://git.clan.lol/clan/clan-core?shallow=1";
    treefmt-nix.url = "github:numtide/treefmt-nix?shallow=1";
    srvos.url = "github:nix-community/srvos?shallow=1";
    flake-parts.url = "github:hercules-ci/flake-parts?shallow=1";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { ... }:
      {
        systems = [
          "x86_64-linux"
        ];

        imports = [
          ./nix/checks.nix
          ./nix/clan.nix
          ./nix/devshells.nix
          ./nix/formatter.nix
        ];
      }
    );
}
