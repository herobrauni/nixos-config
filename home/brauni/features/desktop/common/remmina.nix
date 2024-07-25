{ pkgs
, config
, ...
}: {
  programs.remmina = {
    enable = true;
    package = pkgs.remmina;
  };

  home = {
    persistence = {
      "/persist/${config.home.homeDirectory}".directories = [
        # ".config/Code"
        # ".vscode"
      ];
    };
  };
}
