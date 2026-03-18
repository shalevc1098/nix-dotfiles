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
      "match:class ^Minecraft, float on"
      "match:class ^Minecraft, center on"
    ];
  };

  programs.niri.settings.window-rules = [
    {
      matches = [{ app-id = "^Minecraft"; }];
      open-floating = true;
    }
  ];
}
