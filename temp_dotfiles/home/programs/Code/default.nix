{ pkgs, ... }:

{
  home.file.".config/Code/User/keybindings.json".source = ./keybindings.json;
  home.file.".config/Code/User/settings.json".source = ./settings.json;
}
