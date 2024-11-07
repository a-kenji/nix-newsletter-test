# Administration

## Apply/Update NixOS configuration

```
clan machines update
```

Might need to manually accept ssh connection prior, depending on ssh configuration (host-key-verification).


## Update hardware configuration

```
clan machines narmora update-hardware-config --backend nixos-facter
```
