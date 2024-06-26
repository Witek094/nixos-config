{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.nixos.desktop;
in {
  imports = [
    ./services.nix
  ];
  config = mkIf (cfg.session == "hyprland") {
    environment.systemPackages = with pkgs; [
      cliphist
      kitty
      libnotify
      libsecret
      libvirt
      pamixer
      wl-clipboard
      wlr-randr
      xdg-utils
      xorg.xhost
    ];

    # Hardware and Environment Configuration
    hardware.bluetooth.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    # Enable Hyprland
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    # XDG Portal
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    # Polkit
    security.polkit.enable = true;

    # Enable GNOME PolKit agent
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    # Environment Variables Configuration
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    # Fonts Configuration
    fonts.packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
      # Add more fonts here if needed
    ];
  };
}
