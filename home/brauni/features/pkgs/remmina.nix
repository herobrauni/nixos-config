{ pkgs
, config
, ...
}: {
  services.remmina = {
    enable = true;
    package = pkgs.remmina;
  };

  home = {
    persistence = {
      "/persist/${config.home.homeDirectory}".directories = [
        ".local/share/remmina"
      ];
    };
  };
}
