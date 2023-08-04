{ config, pkgs, home-manager, nur, ... } @ args:

{
  users.mutableUsers = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.root.initialHashedPassword = "$6$H4YEUGiO3c/t3Asl$9lu2f4TEUyD/u/AaWi4wc0BjhZi5uX75CkS4GKHXwNTznL9xLFMMtJ/rswf.sxZcpv3bKMS50lT7Ge0JF0B89/";
  users.users.brauni = {
    initialHashedPassword = "$6$XnsTW2.MFVryaAy2$63WxVlLVkQJ1vupvf45W6DCbVr1vl3aQvtNgw9Sx3wUswY8PTGZ1y2K6waoZsi/WVp2pAsw7ckhDCCd/tQpOI0";
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };
}