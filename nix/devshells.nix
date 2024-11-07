_: {
  perSystem =
    {
      pkgs,
      self',
      inputs',
      ...
    }:
    {
      devShells = {
        default = pkgs.mkShellNoCC {
          name = "twin";
          inputsFrom = [ ];
          packages = [
            self'.formatter.outPath
            inputs'.clan.packages.default
          ];
        };
      };
    };
}
