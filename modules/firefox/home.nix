{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    firefoxpwa
    pywalfox-native
  ];

  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    nativeMessagingHosts = [
      pkgs.firefoxpwa
      pkgs.pywalfox-native
    ];

    package = pkgs.firefox.overrideAttrs (old: {
      postFixup = (old.postFixup or "") + ''
        wrapProgram $out/bin/firefox --set GTK_USE_PORTAL 1
      '';
    });

    profiles.default = {
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        darkreader
        export-cookies-txt
        mal-sync
        pywalfox
        tampermonkey
        ublock-origin
      ];

      settings = {
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.hardware-video-decoding.force-enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "layers.acceleration.force-enabled" = true;

        "signon.rememberSignons" = false;
        "browser.download.dir" = "${config.home.homeDirectory}/Downloads";
        "browser.download.skipConfirmLaunchExecutable" = true;
        "browser.translations.mostRecentTargetLanguages" = "en";
        "browser.translations.neverTranslateLanguages" = "he";
      };
    };
  };
}
