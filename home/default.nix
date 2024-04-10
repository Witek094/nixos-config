{
  inputs,
  withSystem,
  ...
}: let
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in {
  flake.homeConfigurations = withSystem "x86_64-linux" ({pkgs, ...}: {
    "witek@Supremacy" = homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs;};
      modules = [
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
        inputs.hyprland-hypridle.homeManagerModules.hypridle
        inputs.hyprland-hyprlock.homeManagerModules.hyprlock
        ./users/witek
        ../modules/home
      ];
    };
  });
}
