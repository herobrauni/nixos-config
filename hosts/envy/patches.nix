{ config, lib, pkgs, ... } @ args:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

#  boot.kernelPatches = [
#    {
#      name = "sound_1";
#      patch = ./sound_envy/1.patch;
#    }
#    {
#      name = "sound_2";
#      patch = ./sound_envy/2.patch;
#    }
#    {
#      name = "sound_3";
#      patch = ./sound_envy/3.patch;
#    }
#    {
#      name = "sound_4";
#      patch = ./sound_envy/4.patch;
#    }
#    {
#      name = "sound_5";
#      patch = ./sound_envy/5.patch;
#    }
#  ];
}
