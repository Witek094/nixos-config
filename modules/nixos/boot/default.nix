{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.boot;
in {
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = lib.mkForce (!cfg.secure-boot.enable);
        consoleMode = "max";
      };
      timeout = 1;
    };
    lanzaboote = mkIf cfg.secure-boot.enable {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    plymouth = {
      enable = true;
    };
    kernel.sysctl = {
      "vm.max_map_count" = 16777216;
      "fs.file-max" = 524288;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  environment.systemPackages = with pkgs; [
    sbctl
    efibootmgr
    e2fsprogs.bin
  ];
}
