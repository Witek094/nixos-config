{pkgs, ...}: {
  imports = [
    ./disko.nix
    ./hardware.nix
  ];

  modules.nixos = {
    shell = "zsh";
  };

  networking = {
    hostName = "Supremacy";
    networkmanager.enable = true;
  };

  users.users.witek = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
  };

  time.timeZone = "Europe/Warsaw";

  services.xserver.xkb.layout = "pl";

  system.stateVersion = "23.11";
}
