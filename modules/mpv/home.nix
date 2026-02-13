{
  pkgs,
  ...
}:
{
  programs.mpv = {
    enable = true;
    config = {
      # Audio settings
      volume-max = 150;
      volume = 100;

      # Video settings
      hwdec = "auto";
      vo = "gpu-next";

      # Interface
      osd-level = 1;
      osd-duration = 2500;
    };
  };
}