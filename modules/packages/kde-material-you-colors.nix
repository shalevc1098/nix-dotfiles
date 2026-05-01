{ pkgs, ... }:

let
  kde-material-you-colors = pkgs.python3Packages.buildPythonApplication rec {
    pname = "kde-material-you-colors";
    version = "2.2.0";
    
    pyproject = true;
    
    src = pkgs.fetchFromGitHub {
      owner = "luisbocanegra";
      repo = "kde-material-you-colors";
      rev = "v${version}";
      sha256 = "sha256-sN7u3jePevJnTHhQL6eAYKU2AD2QNW7VYuEHLN5RsK8=";
    };
    
    build-system = with pkgs.python3Packages; [
      setuptools
      wheel
    ];
    
    dependencies = with pkgs.python3Packages; [
      pillow
      materialyoucolor
      dbus-python
      python-magic
      numpy
    ];

    doCheck = false; # Skip tests

    # Create a wrapper that suppresses the plasma-apply-colorscheme error
    postInstall = ''
      mv $out/bin/kde-material-you-colors $out/bin/.kde-material-you-colors-real
      cat > $out/bin/kde-material-you-colors <<'EOF'
#!/usr/bin/env bash
# Run the real command and ignore exit code 1 (from plasma-apply-colorscheme failing)
$out/bin/.kde-material-you-colors-real "$@"
exit_code=$?
if [[ $exit_code -eq 1 ]]; then
  exit 0
else
  exit $exit_code
fi
EOF
      substituteInPlace $out/bin/kde-material-you-colors --replace '$out' "$out"
      chmod +x $out/bin/kde-material-you-colors
    '';
    
    meta = with pkgs.lib; {
      description = "Material You colors generator for KDE";
      homepage = "https://github.com/luisbocanegra/kde-material-you-colors";
      license = licenses.gpl3Plus;
      maintainers = [ ];
    };
  };
in
{
  kde-material-you-colors = kde-material-you-colors;
}