{ pkgs
, lib
, config
, inputs
, outputs
, ...
}: {
  imports = [
    ../common
    inputs.niri.homeModules.niri
  ];

  programs.niri.enable = true;

  home = {
    persistence = {
      "/persist/${config.home.homeDirectory}".directories = [
        ".config/niri"
      ];
    };
  };
}
