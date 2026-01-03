{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    (bottles.override { removeWarningPopup = true; })
  ];

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class com.usebottles.bottles, opacity 0.86 0.79"
    ];
  };
}
