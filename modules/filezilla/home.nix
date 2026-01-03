{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    filezilla
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class filezilla, opacity 0.86 0.79"
    ];
  };
}
