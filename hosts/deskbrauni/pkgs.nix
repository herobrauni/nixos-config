{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
