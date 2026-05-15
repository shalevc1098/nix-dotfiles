let
  pipTitle = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
  dialogTitles = [
    "^(Open File)(.*)$"
    "^(Select a File)(.*)$"
    "^(Choose wallpaper)(.*)$"
    "^(Open Folder)(.*)$"
    "^(Save As)(.*)$"
    "^(Library)(.*)$"
    "^(File Upload)(.*)$"
  ];
  dialogFloatCenter = map (t: { match = { title = t; }; float = true; center = true; }) dialogTitles;

  noAnimLayers = [ "walker" "selection" "overview" "anyrun" "indicator.*" "osk" "hyprpicker" "noanim" ];
  noAnimLayerRules = map (n: { match = { namespace = n; }; no_anim = true; }) noAnimLayers;
in
{
  window_rule =
    [
      # Disable blur for XWayland windows
      { match = { xwayland = true; }; no_blur = true; opacity = "1.0 1.0"; }

      # Floating windows
      { match = { class = "blueberry.py"; }; float = true; }

      # Picture-in-Picture
      {
        match = { title = pipTitle; };
        float = true;
        keep_aspect_ratio = true;
        move = [ "73%" "72%" ];
        size = [ "(monitor_w*0.25)" "(monitor_h*0.25)" ];
        pin = true;
      }
    ]
    ++ dialogFloatCenter
    ++ [
      # Tearing
      { match = { title = ".*\\.exe"; }; immediate = true; }
      { match = { class = "^(steam_app)"; }; immediate = true; }

      # No shadow for tiled windows (matches windows that are not floating).
      # { match = { float = false; }; no_shadow = true; }
    ];

  workspace_rule = [
    { workspace = "special:special"; gaps_out = 30; }
  ];

  layer_rule =
    [
      { match = { namespace = ".*"; }; xray = true; }
      # { match = { namespace = ".*"; }; no_anim = true; }
    ]
    ++ noAnimLayerRules
    ++ [
      { match = { namespace = "gtk-layer-shell"; }; blur = true; ignore_alpha = 0.0; }
      { match = { namespace = "launcher"; }; blur = true; ignore_alpha = 0.5; }
      { match = { namespace = "notifications"; }; blur = true; ignore_alpha = 0.69; }
      { match = { namespace = "logout_dialog"; }; blur = true; }
    ];
}
