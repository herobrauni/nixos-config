{
  config,
  pkgs,
  lib,
  ...
}: {

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /mnt
    mount -t btrfs /dev/mapper/enc /mnt
    btrfs subvolume delete /mnt/@nixos_root
    btrfs subvolume snapshot /mnt/@nixos_root_blank /mnt/@nixos_root
  '';

  environment.persistence."/persist" = {
    directories = [
      "/etc/ssh"
      "/etc/NetworkManager"
      "/var/db/sudo/lectured"
      "/kernels"
      "/etc/secureboot"
    ];
    files = [
      "/etc/machine-id"
      "/etc/nix/id_rsa"
      "/var/lib/logrotate.status"
      # "/shared.password"
    ];
  };
}

