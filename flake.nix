{
  description = "A very basic flake";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    default = import ./default.nix { nixpkgs = nixpkgs.legacyPackages.${system}; };
  in
  rec {
    packages.${system} = {
      intel-reg-pp = default.intel-reg-pp;
      msr-output = default.msr_output;
    };
    defaultPackage.${system} = default.intel-reg-pp;
    apps.${system}.msr-output = {
      type = "app";
      program = "${packages.${system}.msr-output}";
    };
    defaultApp.${system} = apps.${system}.msr-output;
  };
}
