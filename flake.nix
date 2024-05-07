{
  description = "rickydodd's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:rickydodd/nixvim";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixvim,
    ...
  }: {
    nixosConfigurations = {
      prometheus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./system.nix
          ./hosts/prometheus

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit nixvim;};
              useGlobalPkgs = true;
              useUserPackages = true;
              users.simian = import ./home/prometheus;
            };
          }
        ];
      };
    };
  };
}
