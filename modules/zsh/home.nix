{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    initContent = ''
      export PATH="$HOME/.local/bin:$PATH"

      eval "$(starship init zsh)"

      # Use the generated color scheme
      if test -f ~/.local/state/ags/user/generated/terminal/sequences.txt; then
          cat ~/.local/state/ags/user/generated/terminal/sequences.txt
      fi
    '';
  };
}
