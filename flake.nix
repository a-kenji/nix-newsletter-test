{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?shallow=1";

    clan.url = "git+https://git.clan.lol/clan/clan-core?shallow=1";
    clan.inputs.nixpkgs.follows = "nixpkgs";
    clan.inputs.flake-parts.follows = "flake-parts";
    clan.inputs.treefmt-nix.follows = "treefmt-nix";

    flake-parts.url = "github:hercules-ci/flake-parts?shallow=1";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix?shallow=1";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";

    srvos.url = "github:nix-community/srvos?shallow=1";
    srvos.inputs.nixpkgs.follows = "nixpkgs";

    hebbot.url = "github:a-kenji/hebbot?ref=feat/publish";
    hebbot.flake = false;

    phaer-keys.url = "https://github.com/phaer.keys";
    phaer-keys.flake = false;

    pinpox-keys.url = "https://github.com/pinpox.keys";
    pinpox-keys.flake = false;

    hsjobeki-keys.url = "https://github.com/hsjobeki.keys";
    hsjobeki-keys.flake = false;
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
          ./nix/packages.nix
          ./nix/devshells.nix
          ./nix/formatter.nix
        ];
      }
    );
}
