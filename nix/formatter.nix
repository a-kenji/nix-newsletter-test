{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = _: {
    treefmt = {
      projectRootFile = ".git/config";
      programs.nixfmt.enable = true;
      programs.taplo.enable = true;
      settings.global.excludes = [
        "*/facter.json"
        "LICENSE"
        "sops/*"
      ];
    };
  };
}
