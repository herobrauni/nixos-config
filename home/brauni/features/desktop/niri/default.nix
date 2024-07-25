{ pkgs
, config
, inputs
, outputs
, ...
}: {
  imports = [ ../common ];

  programs.niri.enable = true;

  home = {
    persistence = {
      "/persist/${config.home.homeDirectory}".directories = [
        ".config/xfce4"
      ];
    };
  };
}
