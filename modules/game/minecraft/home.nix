{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    prismlauncher
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:title ^Minecraft Console Edition$, float on"
    ];
  };

  programs.niri.settings.window-rules = [
    {
      matches = [{ title = "^Minecraft Console Edition$"; }];
      open-floating = true;
    }
  ];
}
