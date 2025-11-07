{ pkgs }:

pkgs.kdePackages.breeze-icons.overrideAttrs (oldAttrs: {
  pname = "breeze-icons-patched";

  postInstall = (oldAttrs.postInstall or "") + ''
    # Apply the breeze-folder-icons-patcher modifications

    light_folder_badge_opacity=1.0
    dark_folder_badge_opacity=1.0

    # Find and patch light icons (only those with ColorScheme-Text)
    echo "Patching light icons..."
    for file in $(find $out/share/icons/breeze/places/ -type f \
      ! -name "*16*" ! -name "*22*" ! -name "*symbolic*" ! -name "*-symbolic.svg" -name "folder-*.svg"); do
      if grep -q "ColorScheme-Text" "$file"; then
        # Badge text to background
        sed -i 's/class="ColorScheme-Text"/class="ColorScheme-Background"/g' "$file"
        # Badge opacity - match exactly like the original script with quotes
        sed -i "s/\"fill:currentColor;fill-opacity:*.*\;stroke:none\"/\"fill:currentColor;fill-opacity:$light_folder_badge_opacity\;stroke:none\"/g" "$file"
      fi
    done

    # Find and patch dark icons (only those with ColorScheme-Text)
    echo "Patching dark icons..."
    for file in $(find $out/share/icons/breeze-dark/places/ -type f \
      ! -name "*16*" ! -name "*22*" ! -name "*symbolic*" ! -name "*-symbolic.svg" -name "folder-*.svg"); do
      if grep -q "ColorScheme-Text" "$file"; then
        # Badge text to background
        sed -i 's/class="ColorScheme-Text"/class="ColorScheme-Background"/g' "$file"
        # Badge opacity - match exactly like the original script with quotes
        sed -i "s/\"fill:currentColor;fill-opacity:*.*\;stroke:none\"/\"fill:currentColor;fill-opacity:$dark_folder_badge_opacity\;stroke:none\"/g" "$file"
      fi
    done

    echo "Breeze folder icons patched successfully"
  '';
})
