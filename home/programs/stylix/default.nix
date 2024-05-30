{ pkgs, ... }:

{
  stylix = {
    image = "../../wallpapers/anime.jpg";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-dune.yaml"; # black-metal-bathory.yaml";

    fonts = {
      serif = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font Mono";
      };
      monospace = {
        package = pkgs.nerdfonts;
        name = "FiraCode Nerd Font Mono";
      };

      
      sizes = {
        desktop = 12;
        applications = 12;
        terminal = 12;
        popups = 12;
      };

    };
  };
}
