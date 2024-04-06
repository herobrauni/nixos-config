{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ollama
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
