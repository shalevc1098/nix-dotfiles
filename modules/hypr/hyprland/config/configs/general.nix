{
  source = [
    "~/.config/hypr/colors.conf"
  ];

  monitor = [
    "desc:Dell Inc. AW3225QF 68F3YZ3, 3840x2160@239.99Hz, 0x0, 1.5"
    "desc:LG Electronics LG ULTRAGEAR 0x0007412E, 1920x1080@240, auto, 1"
  ];

  input = {
    kb_layout = "us,il";
    kb_options = "grp:alt_shift_toggle";
    numlock_by_default = false;
    accel_profile = "flat";
    repeat_delay = 250;
    repeat_rate = 35;

    touchpad = {
      natural_scroll = "yes";
      disable_while_typing = true;
      clickfinger_behavior = true;
      scroll_factor = 0.5;
    };

    special_fallthrough = true;
    follow_mouse = 1;
  };

  gestures = {
    # workspace_swipe = true;
    workspace_swipe_distance = 700;
    # workspace_swipe_fingers = 4;
    workspace_swipe_cancel_ratio = 0.2;
    workspace_swipe_min_speed_to_force = 5;
    workspace_swipe_direction_lock = true;
    workspace_swipe_direction_lock_threshold = 10;
    workspace_swipe_create_new = true;
  };

  general = {
    gaps_in = 7;
    gaps_out = 7;
    gaps_workspaces = 50;
    border_size = 1;

    # "col.active_border" = "rgba(0DB7D4FF)";
    # "col.inactive_border" = "rgba(31313600)";

    resize_on_border = true;
    no_focus_fallback = true;
    layout = "dwindle";

    allow_tearing = true;
  };

  dwindle = {
    preserve_split = true;
    smart_split = false;
    smart_resizing = false;
  };

  decoration = {
    rounding = 20;

    blur = {
      enabled = true;
      size = 14;
      passes = 6;
      new_optimizations = true;
      xray = true;
      special = true;
      noise = 0.008;
      contrast = 0.82;
      brightness = 1.12;
      vibrancy = 0.5;
      vibrancy_darkness = 0.3;
      popups = true;
      popups_ignorealpha = 0.4;
      ignore_opacity = true;
    };

    shadow = {
      enabled = true;
      range = 12;
      render_power = 3;
      color = "rgba(000000aa)";
    };

    dim_inactive = false;
    dim_strength = 0.1;
    dim_special = 0;
  };

  animations = {
    enabled = true;

    bezier = [
      "linear, 0, 0, 1, 1"
      "md3_standard, 0.2, 0, 0, 1"
      "md3_decel, 0.05, 0.7, 0.1, 1"
      "md3_accel, 0.3, 0, 0.8, 0.15"
      "overshot, 0.05, 0.9, 0.1, 1.1"
      "crazyshot, 0.1, 1.5, 0.76, 0.92"
      "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
      "menu_decel, 0.1, 1, 0, 1"
      "menu_accel, 0.38, 0.04, 1, 0.07"
      "easeInOutCirc, 0.85, 0, 0.15, 1"
      "easeOutCirc, 0, 0.55, 0.45, 1"
      "easeOutExpo, 0.16, 1, 0.3, 1"
      "softAcDecel, 0.26, 0.26, 0.15, 1"
      "md2, 0.4, 0, 0.2, 1"
    ];

    animation = [
      "windows, 1, 3, md3_decel, popin 60%"
      "windowsIn, 1, 3, md3_decel, popin 60%"
      "windowsOut, 1, 3, md3_accel, popin 60%"
      "border, 1, 10, default"
      "fade, 1, 3, md3_decel"
      "layersIn, 1, 3, menu_decel, slide"
      "layersOut, 1, 1.6, menu_accel"
      "fadeLayersIn, 1, 2, menu_decel"
      "fadeLayersOut, 1, 0.5, menu_accel"
      "workspaces, 1, 7, menu_decel, slide"
      "specialWorkspace, 1, 3, md3_decel, slidevert"
    ];
  };

  misc = {
    vfr = 0;
    vrr = 1;
    animate_manual_resizes = false;
    animate_mouse_windowdragging = false;
    enable_swallow = false;
    swallow_regex = "(foot|kitty)";

    disable_hyprland_logo = true;
    force_default_wallpaper = 0;
    allow_session_lock_restore = true;
    disable_watchdog_warning = true;

    initial_workspace_tracking = false;
  };

  opengl = {
    nvidia_anti_flicker = 0;
  };

  render = {
    direct_scanout = true;
  };

  debug = {
    damage_tracking = 0;
  };

  xwayland = {
    force_zero_scaling = true;
  };

  cursor = {
    no_hardware_cursors = 0;
  };
}
