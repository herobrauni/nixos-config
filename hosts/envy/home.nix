{ config, pkgs, ... }:

{

  imports = [];

#  users.users.brauni = {
#    isNormalUser = true;
#    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
#    packages = with pkgs; [
#      firefox
#      tree
#    ];
#    initialHashedPassword = "$y$j9T$d7EVWIrLInhGgEObbWa0A1$jomM5R056rhtJOOBH5vxC6GRnPMdqCb23ZKNWvqv1L9";
#  };
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "brauni";
    homeDirectory = "/home/brauni";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
