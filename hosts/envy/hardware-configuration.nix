# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /mnt
    mount -t btrfs /dev/mapper/enc /mnt
    btrfs subvolume delete /mnt/@nixos_root
    btrfs subvolume snapshot /mnt/@nixos_root_blank /mnt/@nixos_root
  '';

  
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/03de4d73-9d30-407d-b92c-01364b571d99";
      fsType = "btrfs";
      options = [ "subvol=@nixos_root" "compress=zstd" "noatime"  ];
    };

  boot.initrd.luks.devices = {
  	"enc".device = "/dev/disk/by-uuid/4fdaa8db-fafe-4e80-b344-b83f6f0a832a";
  };

#  environment.etc."crypttab".text = ''
#      truecrypt-volume /dev/nvme0n1p5 /shared.password tcrypt-veracrypt,noauto
#    '';

#  fileSystems."/shared".device = "/dev/mapper/truecrypt-volume";

  
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/03de4d73-9d30-407d-b92c-01364b571d99";
      fsType = "btrfs";
      options = [ "subvol=@nixos_home" "compress=zstd" "noatime" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/03de4d73-9d30-407d-b92c-01364b571d99";
      fsType = "btrfs";
      options = [ "subvol=@nixos_nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/etc/nixos" =
    { device = "/dev/disk/by-uuid/03de4d73-9d30-407d-b92c-01364b571d99";
      fsType = "btrfs";
      options = [ "subvol=@nixos_nixos_config" "compress=zstd" "noatime" ];
    };

  fileSystems."/persist" =
    { device = "/dev/disk/by-uuid/03de4d73-9d30-407d-b92c-01364b571d99";
      fsType = "btrfs";
      neededForBoot = true;
      options = [ "subvol=@nixos_persist" "compress=zstd" "noatime" ];
    };

  fileSystems."/var/log" =
    { device = "/dev/disk/by-uuid/03de4d73-9d30-407d-b92c-01364b571d99";
      fsType = "btrfs";
      neededForBoot = true;
      options = [ "subvol=@nixos_log" "compress=zstd" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/045C-6266";
      fsType = "vfat";
      options = [ "dmask=0077" "fmask=0077"  ];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/03de4d73-9d30-407d-b92c-01364b571d99";
      fsType = "btrfs";
      options = [ "subvol=@nixos_swap" "noatime"  ];
    };

  swapDevices = [ { device = "/swap/swapfile"; } ];
  boot.resumeDevice = "/dev/disk/by-uuid/03de4d73-9d30-407d-b92c-01364b571d99";
  boot.kernelParams = [ "resume_offset=3155200" ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
