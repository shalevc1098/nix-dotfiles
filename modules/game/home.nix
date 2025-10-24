{
  home.file.".local/bin/fix-dualsense" = {
    text = ''
      #!/bin/sh
      CONTROLLER_MAC="D0:BC:C1:36:43:04"

      bluetoothctl <<EOF
      remove $CONTROLLER_MAC
      scan on
      trust $CONTROLLER_MAC
      pair $CONTROLLER_MAC
      connect $CONTROLLER_MAC
      scan off
      exit
      EOF
    '';

    executable = true;
  };
}