{pkgs, ...}: {
  home = {
    username = "witek";
    homeDirectory = "/home/witek";
  };

  modules.home = {
    desktop = {
      displays = [
        {
          name = "DP-1";
          hyprland = "3840x2160@120, 2887x0, 1";
        }
        {
          name = "DP-2";
          hyprland = "3840x2160@60, 0x0, 1.33";
        }
      ];
      session = "hyprland";
      flatpak = {
        enable = true;
        groups = ["media"];
        packages = [ "org.prismlauncher.PrismLauncher" "com.discordapp.Discord" "com.valvesoftware.Steam" ];
        overrides = {
          "com.valvesoftware.Steam".Context.sockets = ["x11"];
        };
      };
      power = {
        lockscreen.enable = true;
        hibernation.enable = true;
      };
    };
    terminal = {
      neovim.enable = true;
      mpv.enable = true;
    };
  };

  home.packages = with pkgs; [
    btop
    cava
    brave
    logseq
    trash-cli
    vscode
    fractal
    yubioath-flutter
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
