{ config
, lib
, inputs
, ...
}: {
  home = {
    persistence = {
      "/persist/${config.home.homeDirectory}".directories = [
        ".cache/oh-my-zsh"
      ];
      "/persist/${config.home.homeDirectory}".files = [
        ".zsh_history"
      ];
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    oh-my-zsh = {
      enable = true;
      # https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
      plugins = [
        "git"
        "thefuck" # hit Esc twice after a failed command to get suggestions
        "bgnotify"
      ];
    };
    shellAliases = {
      docker-compose = "podman-compose";
      ls = "eza --icons";
      jq = "jaq";
      f = "fuck"; # in case zsh plugin's #1 suggestion won't do
      # ssh = "kitten ssh";  # for kitty
    };
  };
}
