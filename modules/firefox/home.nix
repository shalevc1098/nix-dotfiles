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
    };
  };
}
