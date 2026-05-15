{
  lib,
  hyprLib,
  hostMonitors,
  ...
}:
let
  configDir = ./configs;
  configFiles = builtins.filter (name: builtins.match ".*\\.nix$" name != null) (
    builtins.attrNames (builtins.readDir configDir)
  );
  importConfig =
    name:
    let
      imported = import (configDir + "/${name}");
    in
    if lib.isFunction imported then imported { inherit hyprLib lib hostMonitors; } else imported;
  mergeConfig =
    set1: set2:
    lib.foldr (
      n: set:
      if set ? ${n} then
        lib.setAttr set n (
          let
            a = set.${n};
            b = set2.${n};
          in
          if (lib.isList a && lib.isList b) then
            a ++ b
          else if (lib.isAttrs a && lib.isAttrs b) then
            mergeConfig a b
          else
            b
        )
      else
        lib.setAttr set n set2.${n}
    ) set1 (lib.attrNames set2);
  mergeConfigList = lib.foldl (a: b: mergeConfig a b) { };
in
mergeConfigList (lib.forEach configFiles importConfig)
