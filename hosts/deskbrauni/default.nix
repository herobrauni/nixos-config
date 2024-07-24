{ config, lib, pkgs, ... } @ args :

{
  imports = [
    ./hardware-configuration.nix
#    ./patches.nix
    ./impermanence.nix
    ./pkgs.nix
#    ./home.nix
    # ./secure-boot.nix
  ];

  time.hardwareClockInLocalTime = true;

  users.users.brauni = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      tree
      discord
    ];
    initialHashedPassword = "$y$j9T$d7EVWIrLInhGgEObbWa0A1$jomM5R056rhtJOOBH5vxC6GRnPMdqCb23ZKNWvqv1L9";
  };
  users.mutableUsers = false;


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

#  boot.lanzaboote = {
#    enable = true;
#    pkiBundle = "/share/secureboot";
#  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
#  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "btrfs" ];
  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;

  hardware.nvidia = {
    modesetting.enable = true;
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    # Enable the Nvidia settings menu,
	  # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;

  networking.hostName = "deskbrauni"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Paris";

  services.xserver.enable = true;

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "intl";

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?
}
