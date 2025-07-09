{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    initContent = ''
      eval "$(starship init zsh)"

      # Use the generated color scheme
      if test -f ~/.local/state/ags/user/generated/terminal/sequences.txt; then
          cat ~/.local/state/ags/user/generated/terminal/sequences.txt
      fi
    '';
  };
}
