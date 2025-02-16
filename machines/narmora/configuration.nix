{
  inputs,
  ...
}:

{
  clan.core.networking.targetHost = "root@188.245.150.72";
  clan.core.sops.defaultGroups = [
    "admins"
  ];

  nix.settings.require-sigs = false;

  imports = [
    ./disko.nix
    ./ssh.nix
    ../../modules/hebbot
    inputs.srvos.nixosModules.server
    inputs.srvos.nixosModules.hardware-hetzner-cloud
    inputs.srvos.nixosModules.mixins-terminfo
    inputs.clan.clanModules.state-version
    inputs.clan.clanModules.sshd
    inputs.clan.clanModules.root-password
  ];

}
