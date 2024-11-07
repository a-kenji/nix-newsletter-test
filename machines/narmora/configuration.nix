{
  inputs,
  ...
}:

{
  clan.core.networking.targetHost = "root@188.245.150.72";

  imports = [
    ./disko.nix
    ../../modules/hebbot
    inputs.srvos.nixosModules.server
    inputs.srvos.nixosModules.hardware-hetzner-cloud
    inputs.srvos.nixosModules.mixins-terminfo
    inputs.clan.clanModules.state-version
    inputs.clan.clanModules.sshd
    inputs.clan.clanModules.root-password
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOu1koO8pJ6t0I+rpSVfjD1m6eDk9KTp8cvGL500tsQ9"
  ];
  services.openssh.settings.PermitRootLogin = "yes";
}
