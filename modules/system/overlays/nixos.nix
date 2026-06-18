{ inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      };

      matugen = inputs.matugen.packages.${prev.stdenv.hostPlatform.system}.default;
    })

    inputs.nur.overlays.default

    (final: prev: {
      zoom-us = prev.zoom-us.overrideAttrs (oldAttrs: {
        dontPatchELF = true;
        dontPreconcateArchives = true;
        
        fixupPhase = ''
          runHook preFixup
          echo "Skipping broken patchelf phase..."
          runHook postFixup
        '';
      });
    })
  ];
}
