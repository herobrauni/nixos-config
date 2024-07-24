{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  users.users.brauni = {
    isNormalUser = true;
    # shell = pkgs.fish;
    extraGroups = ifTheyExist [
      "audio"
      "deluge"
      "docker"
      "git"
      "i2c"
      "libvirtd"
      "lxd"
      "minecraft"
      "mysql"
      "network"
      "podman"
      "video"
      "wheel"
      "wireshark"
    ];

    openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/brauni/ssh.pub);
    hashedPasswordFile = config.sops.secrets.brauni-password.path;
    packages = [pkgs.home-manager];
  };

  sops.secrets.brauni-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.brauni = import ../../../../home/brauni/${config.networking.hostName}.nix;

  # security.pam.services = {
  #   swaylock = {};
  # };
}