{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "papirus-colors";
  version = "unstable-2024";

  src = pkgs.fetchFromGitHub {
    owner = "luisbocanegra";
    repo = "papirus-colors";
    rev = "main";
    sha256 = "sha256-oY7PO7KLFwnqApEdWusL6+2freNArRhsoHayjjrNLW0=";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -r Papirus-Colors* $out/share/icons/
  '';

  meta = with pkgs.lib; {
    description = "Papirus folders with KDE Color Scheme support (patched for darker accent colors)";
    homepage = "https://github.com/luisbocanegra/papirus-colors";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
