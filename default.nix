{ nixpkgs }:

with nixpkgs;

rec {
  intel-reg-pp = stdenv.mkDerivation {
    name = "intel-reg-pp";
    src = ./intel-reg-pp;
    buildPhase = ''
      gcc \
        main.cpp \
        reg_print.c \
        reg_print_args.c \
        reg_print_de.c \
        -I. \
        -O3 \
        -o intel-reg-pp.out
      '';
    installPhase = ''
      mkdir -p $out/bin
      install intel-reg-pp $out/bin/intel-reg-pp
      '';
  };
  msr_output =
    let
      sh = writeScript "msr_output.sh" (builtins.readFile ./intel-reg-pp/msr_output.sh);
    in stdenv.mkDerivation {
      name = "msr_output.sh";
      buildInputs = [intel-reg-pp];
      src = [];
      unpackPhase = ''
        echo no-op
        '';
      buildPhase = ''
        echo no-op
      '';
      installPhase = ''
        install ${sh} $out
      '';
    };
}
