{ config, pkgs, home-manager, nur, ... } @ args:

{
  environment.persistence."/persist" = {
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager"
      "/etc/secureboot"
    ];
    files = [
      "/etc/machine-id"
      "/etc/adjtime"
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key.pub"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/ssh/ssh_host_rsa_key.pub"
    ];
  };


  security.sudo.extraConfig = ''
    # rollback results in sudo lectures after each reboot
    Defaults lecture = never
  '';
}