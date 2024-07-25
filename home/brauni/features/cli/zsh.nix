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
            ".zsh_history"
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
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-syntax-highlighting"; } # Simple plugin installation
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "zsh-users/zsh-completions"; } # Simple plugin installation
        { name = "zsh-users/zsh-colored-man-pages"; } # Simple plugin installation

        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
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
      ls = "eza --icons";
      jq = "jaq";
      f = "fuck"; # in case zsh plugin's #1 suggestion won't do
      # ssh = "kitten ssh";  # for kitty
    };
  };
}
