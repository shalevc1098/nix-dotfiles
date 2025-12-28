{
  inputs,
  pkgs,
  ...
}:
{
  nix.settings = {
    substituters = [ "https://niri.cachix.org" ];
    trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
  };

  imports = [ inputs.niri.nixosModules.niri ];

  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
  };

  environment.systemPackages = [ pkgs.xwayland-satellite ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # NVIDIA VRAM fix for niri
  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text = builtins.toJSON {
    rules = [{
      pattern = {
        feature = "procname";
        matches = "niri";
      };
      profile = "Limit Free Buffer Pool On Wayland Compositors";
    }];
    profiles = [{
      name = "Limit Free Buffer Pool On Wayland Compositors";
      settings = [{
        key = "GLVidHeapReuseRatio";
        value = 0;
      }];
    }];
  };
}
