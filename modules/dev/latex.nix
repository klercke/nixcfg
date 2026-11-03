{
  flake.modules.homeManager.latex =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        (texliveMedium.withPackages (
          ps: with ps; [
            latexmk
            # Not all of these are in medium; extras are harmless
            enumitem
            eso-pic
            needspace
            paracol
            plex
          ]
        ))
      ];

      # Colors come from stylix
      programs.zathura = {
        enable = true;
        options = {
          synctex = true;
          selection-clipboard = "clipboard";
          adjust-open = "width";
          scroll-page-aware = true;
          incremental-search = true;
        };
      };
    };
}
