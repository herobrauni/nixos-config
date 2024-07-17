{
  lib,
  inputs,
  config,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.impermanence];
  modules.impermanence.nixos = {
    enable = true;
    path = "/persist";
    btrfsSubvolumes = {
      enable = true;
      rootSubvolume = "root";
      rootFilesystem = "/dev/mapper/crypted";
    };
  };
}