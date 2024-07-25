{ pkgs
, config
, ...
}: {
  imports = [ ../common ];
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  home = {
    persistence = {
      "/persist/${config.home.homeDirectory}".directories = [
        ".config/xfce4"
      ];
    };
  };
}
