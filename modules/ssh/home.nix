{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    
    # Manually set default values to keep
    matchBlocks."*" = {
      # Add any default settings you want to keep here
      # For example:
      # forwardAgent = false;
      # forwardX11 = false;
      # serverAliveInterval = 0;
    };
  };

  services.ssh-agent.enable = false;
}
