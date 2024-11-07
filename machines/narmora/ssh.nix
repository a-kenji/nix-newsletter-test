{
  inputs,
  ...
}:
{
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOu1koO8pJ6t0I+rpSVfjD1m6eDk9KTp8cvGL500tsQ9" # kenji
  ] ++ (builtins.filter (l: l != [ ]) (builtins.split "\n" (builtins.readFile inputs.phaer-keys)));
  services.openssh.settings.PermitRootLogin = "yes";
}
