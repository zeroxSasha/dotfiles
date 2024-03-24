{ pkgs, ... }:

{
  imports = [
    ./kitty
    ./hypr
    ./rofi
    ./Code
    ./waybar
    ./zsh
  ];
}
