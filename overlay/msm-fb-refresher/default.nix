{stdenv, fetchurl}:

let
  version = "0.1";
in
stdenv.mkDerivation {
  inherit version;
  name = "msm-fb-refresher";

  src = fetchurl {
    url = "https://github.com/AsteroidOS/msm-fb-refresher/archive/v${version}.tar.gz";
    sha256 = "1ndnpx8ah121k9pm40s254hlyks9zabpnsc4sj4rgc5rzwf31wi5";
  };

  CC = "${stdenv.cc}/bin/gcc";

  buildPhase = ''
    $CC refresher.c -o refresher.o -c
    $CC refresher.o -o msm-fb-refresher
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -v msm-fb-refresher $out/bin/
    chmod +x $out/bin/*
  '';
}
