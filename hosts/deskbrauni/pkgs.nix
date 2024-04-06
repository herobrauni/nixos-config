{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    steam
    remmina
    teams-for-linux
    gparted
    vim
    wget
    htop
    btop
    git
    micro
    sbctl
    tree
    vlc
    vscode
  ];
}
