# General niri configuration: outputs, input, layout, animations
{
  # Outputs configuration
  outputs = {
    "Dell Inc. AW3225QF 68F3YZ3" = {
      mode = {
        width = 3840;
        height = 2160;
        refresh = 239.991;
      };
      scale = 1.5;
      position = {
        x = 0;
        y = 0;
      };
      variable-refresh-rate = "on-demand";
    };

    "LG Electronics LG ULTRAGEAR 0x0007412E" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 240.001;
      };
      variable-refresh-rate = "on-demand";
    };
  };

  # Input configuration
  input = {
    keyboard = {
      xkb = {
        layout = "us,il";
        options = "grp:alt_shift_toggle";
      };
      repeat-delay = 250;
      repeat-rate = 35;
    };

    mouse = {
      accel-profile = "flat";
    };

    touchpad = {
      natural-scroll = true;
      dwt = true;
      scroll-factor = 0.5;
      click-method = "clickfinger";
    };

    focus-follows-mouse.enable = true;
  };

  cursor = {
    size = 16;
  };

  # Layout configuration
  layout = {
    gaps = 14;

    default-column-width = {
      proportion = 0.5;
    };

    focus-ring = {
      enable = false;
    };

    border = {
      enable = true;
      width = 1;
    };

    shadow = {
      enable = true;
      softness = 30;
      spread = 5;
      offset = {
        x = 0;
        y = 5;
      };
      color = "#000000aa";
    };

    struts = {
      left = 0;
      right = 0;
      top = 0;
      bottom = 0;
    };
  };

  # Window decorations
  prefer-no-csd = true;

  # Animations configuration
  animations = {
    workspace-switch.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 1000;
      epsilon = 0.0001;
    };

    window-open.kind.easing = {
      duration-ms = 150;
      curve = "ease-out-expo";
    };

    window-close.kind.easing = {
      duration-ms = 100;
      curve = "ease-out-quad";
    };

    horizontal-view-movement.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 800;
      epsilon = 0.0001;
    };

    window-movement.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 800;
      epsilon = 0.0001;
    };

    window-resize.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 800;
      epsilon = 0.0001;
    };

    config-notification-open-close.kind.spring = {
      damping-ratio = 0.6;
      stiffness = 1000;
      epsilon = 0.001;
    };
  };

  # Misc
  screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S_%3f.png";

  # Fix for flickering on 240Hz + NVIDIA
  debug = {
    wait-for-frame-completion-before-queueing = true;
    disable-direct-scanout = true;  # Disable direct scanout to GPU
    disable-cursor-plane = true;    # Disable hardware cursor plane
  };
}
