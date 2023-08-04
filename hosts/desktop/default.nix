# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, home-manager, nur, ... } @ args:

{
  imports =
    [
        # This adds a nur configuration option.
        # Use `config.nur.repos.<user>.<package-name>` in NixOS Module for packages from the NUR.
      nur.nixosModules.nur
      ./hardware-configuration.nix
      ./packages.nix
      ./users.nix
      ./impermanence.nix
    ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1v"
  ];

  nixpkgs.config.allowUnfree = true;

  services.fwupd.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixosdesk"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Chose Desktop and Lock
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  
  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "intl";

  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    htop
    btop
    sbctl
    efibootmgr
    fio
    github-desktop
    vscode
  ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
#  system.stateVersion = "unstable"; # Did you read the comment?
}
