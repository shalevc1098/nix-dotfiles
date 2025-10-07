{
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.docker ];

  programs.docker.enable = true;

  # Create a user command called "shoko"
  home.file.".local/bin/shoko".text = ''
    #!/bin/sh

    # Ensure the directories exist
    mkdir -p $HOME/shoko/config
    mkdir -p $HOME/shoko/database
    mkdir -p $HOME/shoko/media

    # Check if the container is already running
    if docker ps --filter "name=shoko-server" --format '{{.Names}}' | grep -q shoko-server; then
      echo "Shoko Server is already running."
    else
      echo "Starting Shoko Server..."
      docker run -d \
        --name shoko-server \
        -p 8111:8111 \
        -v $HOME/shoko/config:/app/config \
        -v $HOME/shoko/database:/app/database \
        -v $HOME/shoko/media:/app/media \
        shokoanime/server:daily
      echo "Shoko Server started."
    fi

    echo "Access Shoko at: http://localhost:8111"
  '';

  home.file.".local/bin/shoko".executable = true;
}
