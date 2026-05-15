{ lib }:
let
  inherit (lib.generators) mkLuaInline;
in
rec {
  # hl.bind(keys, dispatcher)
  mkBind = keys: disp: { _args = [ keys (mkLuaInline disp) ]; };

  # hl.bind(keys, dispatcher, { ... flags ... })
  mkBindFlags = keys: disp: flags: { _args = [ keys (mkLuaInline disp) flags ]; };

  # hl.dsp.exec_cmd("...") — shorthand for the most common dispatcher
  mkExec = cmd: ''hl.dsp.exec_cmd(${builtins.toJSON cmd})'';

  # Bind that runs an exec_cmd
  mkBindExec = keys: cmd: mkBind keys (mkExec cmd);
  mkBindExecFlags = keys: cmd: flags: mkBindFlags keys (mkExec cmd) flags;

  # hl.curve("name", { type = "bezier", points = {...} })
  mkCurve = name: type: points: {
    _args = [ name { inherit type points; } ];
  };

  # hl.env("KEY", "value")
  mkEnv = key: val: { _args = [ key val ]; };

  # hl.on("hyprland.start", function() hl.exec_cmd("..."); ... end)
  mkStartHook =
    cmds:
    {
      _args = [
        "hyprland.start"
        (mkLuaInline ''
          function()
          ${lib.concatMapStringsSep "\n" (c: "  hl.exec_cmd(${builtins.toJSON c})") cmds}
          end
        '')
      ];
    };
}
