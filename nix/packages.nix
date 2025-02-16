{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages = {
        hebbot = pkgs.callPackage ./packages/hebbot.nix { inherit inputs; };
      };
    };
}
