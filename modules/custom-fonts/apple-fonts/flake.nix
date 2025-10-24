{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs@{ self, nixpkgs }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      forEachSystem = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          # Fetch Apple font DMGs with fixed hashes
          sf-pro = pkgs.fetchurl {
            url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
            sha256 = "1bk9zm8kmdxlxah28a9imh741r60skc23f9kmz0lswwbk19phk9f";
          };
          sf-compact = pkgs.fetchurl {
            url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
            sha256 = "1qxqixgmcndmski6820wgf5dhbgrd5208ij95dqci7prqbx4zhq8";
          };
          sf-mono = pkgs.fetchurl {
            url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
            sha256 = "0ibrk9fvbq52f5qnv1a8xlsazd3x3jnwwhpn2gwhdkdawdw0njkd";
          };
          sf-arabic = pkgs.fetchurl {
            url = "https://devimages-cdn.apple.com/design/resources/download/SF-Arabic.dmg";
            sha256 = "1fcpa488vx3xj9f9hq70gxj4qbgcjaijwz2i94n02xrba0nwcq17";
          };
          sf-armenian = pkgs.fetchurl {
            url = "https://devimages-cdn.apple.com/design/resources/download/SF-Armenian.dmg";
            sha256 = "1bddbz380a6lixmxdcrb1fsrnxw485i88js37yz1bhnpjfp1bmzz";
          };
          sf-georgian = pkgs.fetchurl {
            url = "https://devimages-cdn.apple.com/design/resources/download/SF-Georgian.dmg";
            sha256 = "1lm2j19ypvaf6lx7zyz89xkn14i9r0daa7ik8lj269ib8yc1fsy1";
          };
          sf-hebrew = pkgs.fetchurl {
            url = "https://devimages-cdn.apple.com/design/resources/download/SF-Hebrew.dmg";
            sha256 = "114k1dnyvjamz9xizk2x0rqabsmf31rbzns1jigg9g5q2l3y8n1j";
          };
          ny = pkgs.fetchurl {
            url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
            sha256 = "1x7qi3dqwq1p4l3md31cd93mcds3ba7rgsmpz0kg7h3caasfsbhw";
          };

          unpackPhase = pkgName: ''
            runHook preUnpack
            undmg $src
            7z x '${pkgName}'
            7z x 'Payload~'
            runHook postUnpack
          '';

          commonInstall = ''
            mkdir -p "$out/share/fonts"
            mkdir -p "$out/share/fonts/opentype"
            mkdir -p "$out/share/fonts/truetype"
          '';

          commonBuildInputs = builtins.attrValues { inherit (pkgs) undmg p7zip; };

          makeAppleFont = (
            name: pkgName: src:
            pkgs.stdenvNoCC.mkDerivation {
              inherit name src;

              unpackPhase = unpackPhase pkgName;

              buildInputs = commonBuildInputs;
              setSourceRoot = "sourceRoot=`pwd`";

              installPhase =
                ''runHook preInstall''
                + commonInstall
                + ''
                  find -name \*.otf -exec mv {} "$out/share/fonts/opentype/" \;
                  find -name \*.ttf -exec mv {} "$out/share/fonts/truetype/" \;
                ''
                + ''runHook preInstall'';
            }
          );

          makeNerdAppleFont = (
            name: pkgName: src:
            pkgs.stdenvNoCC.mkDerivation {
              inherit name src;

              unpackPhase = unpackPhase pkgName;

              buildInputs =
                commonBuildInputs
                ++ builtins.attrValues { inherit (pkgs) parallel nerd-font-patcher; };

              setSourceRoot = "sourceRoot=`pwd`";

              buildPhase = ''
                runHook preBuild
                find -name \*.ttf -o -name \*.otf -print0 | parallel --will-cite -j $NIX_BUILD_CORES -0 nerd-font-patcher --no-progressbars -c {}
                runHook postBuild
              '';

              installPhase =
                ''runHook preInstall''
                + commonInstall
                + ''
                  find -name \*.otf -maxdepth 1 -exec mv {} "$out/share/fonts/opentype/" \;
                  find -name \*.ttf -maxdepth 1 -exec mv {} "$out/share/fonts/truetype/" \;
                ''
                + ''runHook preInstall'';
            }
          );
        in
        {
          sf-pro = makeAppleFont "sf-pro" "SF Pro Fonts.pkg" sf-pro;
          sf-pro-nerd = makeNerdAppleFont "sf-pro-nerd" "SF Pro Fonts.pkg" sf-pro;

          sf-compact = makeAppleFont "sf-compact" "SF Compact Fonts.pkg" sf-compact;
          sf-compact-nerd = makeNerdAppleFont "sf-compact-nerd" "SF Compact Fonts.pkg" sf-compact;

          sf-mono = makeAppleFont "sf-mono" "SF Mono Fonts.pkg" sf-mono;
          sf-mono-nerd = makeNerdAppleFont "sf-mono-nerd" "SF Mono Fonts.pkg" sf-mono;

          sf-arabic = makeAppleFont "sf-arabic" "SF Arabic Fonts.pkg" sf-arabic;
          sf-arabic-nerd = makeNerdAppleFont "sf-arabic-nerd" "SF Arabic Fonts.pkg" sf-arabic;

          sf-armenian = makeAppleFont "sf-armenian" "SF Armenian Fonts.pkg" sf-armenian;
          sf-armenian-nerd = makeNerdAppleFont "sf-armenian-nerd" "SF Armenian Fonts.pkg" sf-armenian;

          sf-georgian = makeAppleFont "sf-georgian" "SF Georgian Fonts.pkg" sf-georgian;
          sf-georgian-nerd = makeNerdAppleFont "sf-georgian-nerd" "SF Georgian Fonts.pkg" sf-georgian;

          sf-hebrew = makeAppleFont "sf-hebrew" "SF Hebrew Fonts.pkg" sf-hebrew;
          sf-hebrew-nerd = makeNerdAppleFont "sf-hebrew-nerd" "SF Hebrew Fonts.pkg" sf-hebrew;

          ny = makeAppleFont "ny" "NY Fonts.pkg" ny;
          ny-nerd = makeNerdAppleFont "ny-nerd" "NY Fonts.pkg" ny;
        }
      );
      hydraJobs = {
        inherit (self) packages;
      };
    };
}
