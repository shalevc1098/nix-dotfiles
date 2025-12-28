{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        global.overload_tap_timeout = 200;
        main.leftmeta = "overload(meta, macro(leftmeta+space))";
      };
    };
  };
}
