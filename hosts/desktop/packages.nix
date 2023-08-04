{ config, pkgs, home-manager, nur, ... } @ args:

{  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    htop
    btop
    sbctl
    efibootmgr
    fio
    firefox
  ];
}