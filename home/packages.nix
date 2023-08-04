{config, pkgs, ...}: 

{
  home.packages = with pkgs; [
    firefox
    github-desktop
    vscode

    neofetch
    nnn          # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep  # recursively searches directories for a regex pattern
    jq       # A lightweight and flexible command-line JSON processor
    yq-go    # yaml processer https://github.com/mikefarah/yq
    exa      # A modern replacement for ‘ls’
    fzf      # A command-line fuzzy finder

    # networking tools
    mtr   # A network diagnostic tool
    iperf3
    ldns  # replacement of dig, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap  # A utility for network discovery and security auditing

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    caddy
    gnupg

    # nix related
    # 
    # it provides the command `nom` works just like `nix
    # with more details log output
    nix-output-monitor

    # productivity
    hugo  # static site generator
    glow  # markdown previewer in terminal
  ];

  programs = {
    # A terminal multiplexer
    tmux = {
      enable = true;
    };

    # a cat(1) clone with syntax highlighting and Git integration.
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "Catppuccin-mocha";
      };
      themes = {
        Catppuccin-mocha = builtins.readFile (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme";
          hash = "sha256-qMQNJGZImmjrqzy7IiEkY5IhvPAMZpq0W6skLLsng/w=";
        });
      };
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
  };


  home.shellAliases = {
    k = "kubectl";
    vim = "nvim";
  };
}