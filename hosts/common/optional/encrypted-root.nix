{config, ...}: let
  hostname = config.networking.hostName;
in {
  boot.initrd = {
    luks.devices."${hostname}".device = "/dev/disk/by-partlabel/disk-main-luks";
  };
}
