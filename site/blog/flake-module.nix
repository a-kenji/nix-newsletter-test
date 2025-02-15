{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.nix-newsletter-test = pkgs.callPackage ./package.nix { };
    };
}
