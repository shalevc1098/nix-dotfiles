{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    lyx

    (texlive.combine {
      inherit (texlive)
        scheme-full
        collection-xetex
        collection-langarabic
        ;
    })

    culmus
  ];
}
