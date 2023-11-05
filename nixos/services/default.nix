{ options, config, lib, pkgs, ... }:
let
  cfg = config.jh-devv.nixos.services;
in {
  config = lib.mkIf cfg.enable {
    services = {
      printing.enable = true;
      openssh.enable = true;
      blueman.enable = true;
      gvfs.enable = true;
      udev.packages = [ pkgs.yubikey-personalization ];
      flatpak.enable = true;
    };

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    
  };
}