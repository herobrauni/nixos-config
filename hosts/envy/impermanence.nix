{
  config,
  pkgs,
  lib,
  ...
}: {

  # boot.initrd.postDeviceCommands = lib.mkAfter ''
  #   mkdir /mnt
  #   mount -t btrfs /dev/mapper/enc /mnt
  #   btrfs subvolume delete /mnt/@nixos_root
  #   btrfs subvolume snapshot /mnt/@nixos_root_blank /mnt/@nixos_root
  # '';
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/mapper/enc /btrfs_tmp
    if [[ -e /btrfs_tmp/@nixos_root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/@nixos_root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/@nixos_root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/@nixos_root
    umount /btrfs_tmp
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
      "/shared.password"
    ];
  };
}

