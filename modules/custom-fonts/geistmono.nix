{ stdenv, lib }:

stdenv.mkDerivation {
  pname = "geistmono";
  version = "1.0";
  src = ./GeistMono;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r . $out/share/fonts
  '';

  meta = with lib; {
    description = "Geist Mono typeface";
    license = licenses.mit;
  };
}
