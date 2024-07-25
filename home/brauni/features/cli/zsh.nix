{ config
, lib
, inputs
, ...
}: {
  home = {
    persistence = {
      "/persist/${config.home.homeDirectory}" =
        {
          directories = [
            ".cache/oh-my-zsh"
          ];
          files = [
            # ".zsh_history"
            ".p10k.zsh"
          ];
        };
    };
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    history.path = "$HOME/Documents/zsh_history"; 
    initExtra = "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh";
    antidote = {
      enable = true;
      plugins = [
        "romkatv/powerlevel10k"
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-completions"
        "ael-code/zsh-colored-man-pages"
      ];
    };
    oh-my-zsh = {
      enable = true;
      # https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
      plugins = [
        "git"
        "thefuck" # hit Esc twice after a failed command to get suggestions
        "bgnotify"
        "ansible"
        "pip"
        "kubectl"
        "terraform"
      ];
    };
    shellAliases = {
      docker-compose = "podman-compose";
      # ls = "eza --icons";
      jq = "jaq";
      f = "fuck"; # in case zsh plugin's #1 suggestion won't do
      # ssh = "kitten ssh";  # for kitty
    };
  };
}
