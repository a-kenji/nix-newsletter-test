_: {
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages = {
        hebbot = pkgs.callPackage ./packages/hebbot.nix { };
      };
    };
}
