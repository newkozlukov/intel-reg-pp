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
    };
    defaultPackage.${system} = default.intel-reg-pp;
    apps.${system}.msr-output = {
      type = "app";
      program = "${packages.${system}.intel-reg-pp}/bin/msr_output.sh";
    };
    defaultApp.${system} = apps.${system}.msr-output;
  };
}
