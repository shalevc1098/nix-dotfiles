{ pkgs, ... }:
{
  home.packages = with pkgs; [
    firefoxpwa
    pywalfox-native
  ];

  programs.firefox = {
    enable = true;
    nativeMessagingHosts = [
      pkgs.firefoxpwa
      pkgs.pywalfox-native
    ];
    policies = {
      ExtensionSettings = {
        "addon@darkreader.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        };
      };
      Preferences = {
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "layers.acceleration.force-enabled" = true;
      };
    };
    package = pkgs.firefox.overrideAttrs (old: {
      postFixup = (old.postFixup or "") + ''
        wrapProgram $out/bin/firefox --set GTK_USE_PORTAL 1
      '';
    });
  };
}
