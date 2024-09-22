{ config, pkgs, ... }:

{
  imports = [
    ./programs
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lxudrr";
  home.homeDirectory = "/home/lxudrr"; 

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    firefox
    zoom-us
    redis
    chromium
    tree
    kitty
    git
    gnumake
    wl-clipboard
    grim # for screenshots
    slurp # for screenshots
    obsidian
    libreoffice
    discord
    htop
    telegram-desktop
    obs-studio
    neofetch
    qemu
    rustdesk
    dbeaver
    pavucontrol
    vscode
    gcc
    mc
    insomnia
    mlocate
    cowsay
    lolcat
    smartmontools
    wireshark-qt
    cmake
    direnv
    python3
    docker
    sqlite
    gimp
    xdotool
    wget
    vim
    neovim
    vlc
    nodejs_21
    unzip
    github-desktop
    solc
    krita
    termius
    rustup
    droidcam
    xfce.thunar
    gtk4
    feh
    evince # pdf reader
    virt-manager 
    jq # command-line JSON processor
    zip
    anki-bin
    sysstat
    mtr # Combines the functionality of traceroute and ping into a single diagnostic tool
    nmap # Scans hosts for open ports
    unixtools.netstat # Displays network connections, routing tables, interface statistics, masquerade connections, and multicast memberships
    docker-compose
    ripgrep # A utility that combines the usability of The Silver Searcher with the raw speed of grep
    bat # A cat clone with syntax highlighting and Git integration
    eza # A modern, maintained replacement for ls
    libsixel # The SIXEL library for console graphics, and converter programs
    foot # A fast, lightweight and minimalistic Wayland terminal emulator
	shellcheck
	ansible
	maxima
    wxmaxima
  ];

  # pointer
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.vanilla-dmz;
    name = "Vanilla-DMZ";
  }; 
  

  xdg.mimeApps = {
	enable = true;
	# needed only for several applications you want to choose from
	associations.added = {
		"application/pdf" = ["org.gnome.Evince.desktop"];
		"x-scheme-handler/http" = ["firefox.desktop"];
		"x-scheme-handler/https" = ["firefox.desktop"];
	};
	# needed for default applications
    defaultApplications = {
      "application/pdf" = ["org.gnome.Evince.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
	  "x-scheme-handler/https" = ["firefox.desktop"];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lxudrr/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };
   
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # UnFree Software
  nixpkgs.config.allowUnfree = true;

  # Allow Packages
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "squid-5.9"
  ];
}
