{ ... }:
{
  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="input", ATTRS{name}=="DualSense Wireless Controller Touchpad", ATTR{inhibited}="1"
  '';
}
