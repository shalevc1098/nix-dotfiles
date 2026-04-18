{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire."99-rate" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 44100 48000 ];
        "default.clock.quantum" = 512;
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 2048;
      };
    };
    extraConfig.pipewire."99-loopback" = {
      "context.modules" = [
        {
          name = "libpipewire-module-loopback";
          args = {
            "audio.position" = [
              "FL"
              "FR"
            ];
            "capture.props" = {
              "media.class" = "Audio/Sink";
              "node.name" = "loopback_sink";
              "node.description" = "Loopback Sink";
            };
            "playback.props" = {
              "media.class" = "Audio/Source";
              "node.name" = "loopback_source";
              "node.description" = "Loopback Source";
            };
          };
        }
      ];
    };
  };
}
