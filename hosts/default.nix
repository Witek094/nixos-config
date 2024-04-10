{inputs, ...}: let
  inherit (inputs.nixpkgs.lib) nixosSystem;
in {
  flake.nixosConfigurations = {
    Supremacy = nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./Supremacy
        ../modules/nixos
        {
          modules.nixos.boot.secure-boot.enable = false;
        }
        inputs.lanzaboote.nixosModules.lanzaboote
      ];
    };
  };
}
