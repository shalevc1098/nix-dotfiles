{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    polychromatic
  ];

  hardware.openrazer = {
    enable = true;
    users = [ username ];
  };

  # openrazer 3.12.2 (nixpkgs) calls hid_report_raw_event() with the old 5-arg
  # form; kernel 7.0 inserted a `size_t bufsize` param before `u32 size`. xdata
  # is a fixed u8[22] and the whole buffer is the report, so bufsize == size.
  # Upstream fix shipped in openrazer 3.12.3 — drop this once nixpkgs ships it.
  nixpkgs.overlays = [
    (final: prev: {
      linuxPackages_latest = prev.linuxPackages_latest.extend (lfinal: lprev: {
        openrazer = lprev.openrazer.overrideAttrs (old: {
          postPatch = (old.postPatch or "") + ''
            substituteInPlace driver/razerkbd_driver.c \
              --replace-fail \
                'hid_report_raw_event(hdev, HID_INPUT_REPORT, xdata, sizeof(xdata), 0);' \
                'hid_report_raw_event(hdev, HID_INPUT_REPORT, xdata, sizeof(xdata), sizeof(xdata), 0);'
          '';
        });
      });
    })
  ];
}
