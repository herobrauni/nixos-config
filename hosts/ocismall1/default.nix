{ config, pkgs,  ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "ocismall1";
  networking.domain = "";
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDC6ggBsKqXQtob8ing02Kv72PYoQ+IvqpesqZzfyvIoGM/NPPfA2DKpTYyOqn1djzLfp7LM1FhK2sqTIL5xGaofllYuJQkmQOovgwbdA2rRrN4ufxnD2IJWTJYNLW/OjOe9Tgi4tZThRfVNiit6U/Sl1G3cymmmz1m29uQgoWd1BwdH9g7mJWnaMAV50XmiM7ujLO2j2KGqzC8i2mHejywMyN5eltuRz5pR3NHCaZ4MEfhtwoO6u/miqXClsw2gCD+z77TeuO/E+E/tk45OVf1Po1AdhjueQm374dyeY0GeYeMqHd/HbWgKcqtGUzemP3h6Wp66oCGfi92Jgxa3lzIkSMyYJH0+m7gY6bYMhuhK5YEWcfefQL2nEHQUMlw1tPacmxEU06VDoyIURhIdV0n9w/I2w/V2Mqmy1gJZ1dKuyicafppqcAcmu9aB0I6LjyJNm7ABUnrrpj/sNoIlJeaaw8jhPXTYpkeujABm5xGm7A7YvC/V1HPzcio22L1ErM= brauni@Desktop'' ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEnkGvemDNQZilnTXhcKHRBFpAmzr57bBN7t/CJyW6988mGyD4H+pQ8OUCdQ744tNfaMN6NAPJJJLqKBnkk7lQEb9BSnMIkmG/bRVMHfJtKIhDUU6LOnRZoNkhqqk01dqkR/JnehxnBWM353MEhT9H9X42HNtY07VWBnJeMufcPWjjyLjb7G08Jm9MJEUFL65USk4y6vNnjN74iLhDGPzE3/ucOlp6ycK08LxStsZlwePV/lcncFzPe5Tu2yo/IAdYoXhppIlH5Drdn3hQt56gzAlp/FJbBHcdKqPTNFRfvbxYzhPnD/BcRaeIoNCYoi1DPLcTZ4pMVIrLQQcWQ5RDs0gQg0EAyAF8WhCbMHHMdrjtpwzvksOyDOnazX5dxCp2aqAfIwQ5/CtYG+2okImTE4CBhhwBjafpFVs6TDVMp6++pReF+TbDd67ykFRshB7G8sDtvvwVs4rzSF8geC6ui30lQ1hSy1v9Akm4GWCQ8mbFwXCG6VSMHgNeqSwDuuE= brauni@phone'' ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC38bMw374lfi+Hv776RkuSiJjJC4qHaoc65uvy8IGZT444J3rm8OEVnIfX8W2IOQsF6zVds0G2ebfdlV0JAkRMhPV68RqHAWQw/WrmGMpcFr1gskxV6alxyq14Qach7jqE+A36M8jlxqILlabMOpCG/d60/ZtHf3v6QYR2ygI/dbrPyM/gW6zo6UyQuAPNVd5Z1HcrTHsPbN8SWoC2Ui85mTlzSiB3HuJIo2wpf5C0gWpXMVd/wUEtLiOzgNUOFlRsBYhu9YidU/rjBPA/bt/K4T+BeQsaNedRPSZRjP1Upqz760hvR39nHjM0d76tZymDIUBEkXLOBPfB3T3b/NlfUqnRzh+Sg4txXkJm8gG/5Lyu+H9QqZ+4d/SuNHGnr3RcEQtsSn1ey1v3z7S912H5C24eevn4dfpx7cA8rHUlDeL7Uufji9m2QD3ooNlr+Wfb5Fb3lhB5mBlMxnsZPA8qTCSh7U/CzZXHZugyKFozsfb9ppVMVTGeik+k/KeC5Fs= brauni@thinkpad'' ''ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDC6ggBsKqXQtob8ing02Kv72PYoQ+IvqpesqZzfyvIoGM/NPPfA2DKpTYyOqn1djzLfp7LM1FhK2sqTIL5xGaofllYuJQkmQOovgwbdA2rRrN4ufxnD2IJWTJYNLW/OjOe9Tgi4tZThRfVNiit6U/Sl1G3cymmmz1m29uQgoWd1BwdH9g7mJWnaMAV50XmiM7ujLO2j2KGqzC8i2mHejywMyN5eltuRz5pR3NHCaZ4MEfhtwoO6u/miqXClsw2gCD+z77TeuO/E+E/tk45OVf1Po1AdhjueQm374dyeY0GeYeMqHd/HbWgKcqtGUzemP3h6Wp66oCGfi92Jgxa3lzIkSMyYJH0+m7gY6bYMhuhK5YEWcfefQL2nEHQUMlw1tPacmxEU06VDoyIURhIdV0n9w/I2w/V2Mqmy1gJZ1dKuyicafppqcAcmu9aB0I6LjyJNm7ABUnrrpj/sNoIlJeaaw8jhPXTYpkeujABm5xGm7A7YvC/V1HPzcio22L1ErM= brauni@Desktop'' ];
  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    cron
    sysbench
  ];
}