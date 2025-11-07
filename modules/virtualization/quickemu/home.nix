{
  home.file.".local/bin/windows11" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      set -eu

      quickemu --vm ~/vms/windows-11.conf --display spice --viewer remote-viewer
    '';
  };
}
