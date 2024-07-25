{ pkgs
, config
, inputs
, outputs
, ...
}: {
  imports = [ ../common ];

  home = {
    persistence = {
      "/persist/${config.home.homeDirectory}".directories = [
        ".config/xfce4"
      ];
    };
  };
}
