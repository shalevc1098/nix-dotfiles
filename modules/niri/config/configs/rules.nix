# Niri window rules
{
  window-rules = [
    # Global corner radius for all windows
    {
      geometry-corner-radius = {
        top-left = 20.0;
        top-right = 20.0;
        bottom-left = 20.0;
        bottom-right = 20.0;
      };
      clip-to-geometry = true;
    }

    # Floating windows by app-id
    {
      matches = [{ app-id = "^blueberry\\.py$"; }];
      open-floating = true;
    }
    {
      matches = [{ app-id = "^steam$"; }];
      open-floating = true;
    }
    {
      matches = [{ app-id = "^guifetch$"; }];
      open-floating = true;
    }
    {
      matches = [{ app-id = "^pavucontrol$"; }];
      open-floating = true;
    }
    {
      matches = [{ app-id = "^org\\.pulseaudio\\.pavucontrol$"; }];
      open-floating = true;
    }
    {
      matches = [{ app-id = "^nm-connection-editor$"; }];
      open-floating = true;
    }
    {
      matches = [{ app-id = "^heroic$"; }];
      open-floating = true;
    }

    # Force tiling for Warp terminal
    {
      matches = [{ app-id = "^dev\\.warp\\.Warp$"; }];
      open-floating = false;
    }

    # Picture-in-Picture
    {
      matches = [{ title = "(?i)picture.?in.?picture"; }];
      open-floating = true;
    }

    # File dialog windows
    {
      matches = [{ title = "^Open File"; }];
      open-floating = true;
    }
    {
      matches = [{ title = "^Select a File"; }];
      open-floating = true;
    }
    {
      matches = [{ title = "^Choose wallpaper"; }];
      open-floating = true;
    }
    {
      matches = [{ title = "^Open Folder"; }];
      open-floating = true;
    }
    {
      matches = [{ title = "^Save As"; }];
      open-floating = true;
    }
    {
      matches = [{ title = "^Library"; }];
      open-floating = true;
    }
    {
      matches = [{ title = "^File Upload"; }];
      open-floating = true;
    }
  ];
}
