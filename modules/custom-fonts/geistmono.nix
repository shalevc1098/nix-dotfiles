{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "geistmono";
  version = "1.0";
  src = ./GeistMono;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp -r . $out/share/fonts/opentype
  '';

  meta = with lib; {
    description = "Geist Mono typeface";
    license = licenses.mit;
  };
}
