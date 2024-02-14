{ config, lib, pkgs, modulesPath, ... }:

{
  environment.persistence."/persist" = { 
    directories = [
      "/etc/ssh"
      "/etc/NetworkManager"
      "/var/db/sudo/lectured"
      "/kernels"
    ];
    files = [
      "/etc/machine-id"
      "/etc/nix/id_rsa"
      "/var/lib/logrotate.status"
      "/shared.password"
    ];
  };
}

