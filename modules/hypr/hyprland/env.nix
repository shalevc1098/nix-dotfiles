{
  config,
  hyprLib,
  lib,
  ...
}:
let
  assignable = _: value: !(lib.hasInfix "\${" (toString value));

  luaValue =
    value:
    let
      string = toString value;
      reference = builtins.match "\\$([A-Z_][A-Z0-9_]*)(.*)" string;
    in
    if reference == null then
      string
    else
      lib.generators.mkLuaInline ''os.getenv("${lib.elemAt reference 0}") .. ${builtins.toJSON (lib.elemAt reference 1)}'';
in
{
  wayland.windowManager.hyprland.settings.env = lib.mapAttrsToList (
    name: value: hyprLib.mkEnv name (luaValue value)
  ) (lib.filterAttrs assignable config.home.sessionVariables);
}
