{
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        global.overload_tap_timeout = 0;
        main.leftmeta = "overload(meta, macro(leftmeta+space))";
      };
    };
  };
}
