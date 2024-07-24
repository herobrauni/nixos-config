# inspiration: https://github.com/nix-community/disko/blob/master/example/luks-btrfs-subvolumes.nix
{ inputs
, config
, ...
}:
let
  hostname = config.networking.hostName;
in
{
  imports = [ inputs.disko.nixosModules.disko ];
  disko.devices.disk = {
    "main" = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "2G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "umask=0077"
              ];
              extraArgs = "-L ESP";
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "${hostname}";
              settings = {
                allowDiscards = true;
                bypassWorkqueues = true;
              };
              content = {
                type = "btrfs";
                extraArgs = [ "-f" 
                "-L ${hostname}"
                ];
                
                subvolumes = {
                  # the subvolume we wanna wipe
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  fileSystems = {
    "/persist".neededForBoot = true;
    "/var/log".neededForBoot = true;
  };
}
