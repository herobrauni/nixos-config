{ pkgs
, config
, ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      #    bbenoist.Nix
      #       justusadam.language-haskell
    ];
  };

  home = {
    persistence = {
      "/persist/${config.home.homeDirectory}".directories = [
        ".config/Code"
        ".vscode"
      ];
    };
  };
}
