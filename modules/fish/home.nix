{
  programs.fish = {
    enable = true;

    shellInit = ''
      source ~/.config/fish/colors.fish

      export PATH="$HOME/.local/bin:$PATH"
      
      starship init fish | source
    '';

    interactiveShellInit = ''
      set fish_greeting

      function __matugen_reload_colors --on-variable __matugen_theme
        source ~/.config/fish/colors.fish
      end
    '';

    functions = {
      fish_prompt = {
        description = "Write out the prompt";
        body = ''
          printf '%s@%s %s%s%s > ' $USER $hostname \
            (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
        '';
      };
    };
  };

  programs.man.generateCaches = false;
}
