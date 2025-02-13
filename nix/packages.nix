{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages = {
        hebbot = pkgs.hebbot.overrideAttrs (
          old:
          let
            name = "hebbot-2.1-unstable-2024-11-14";
            src = inputs.hebbot;
          in
          {
            inherit name src;
            cargoDeps = old.cargoDeps.overrideAttrs ({
              name = "${old.pname}-vendor.tar.gz";
              inherit src;
              outputHash = "sha256-g9pWFE4G2/aPNQUbg8Etb5UFDIsiDKHLMiAp+1xMd1g=";
            });
          }
        );
      };
    };
}
