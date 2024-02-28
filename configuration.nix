{ config, lib, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ./home/programs/stylix/default.nix
  ];
  
  users.users.sasha.isNormalUser = true;
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };

    kernelPackages = pkgs.linuxPackages_latest; # Get latest linux kernel
  };

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-k22n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    layout = "us";
  };
  
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };  
  
  # ZRAM
  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;

  # garbage collect
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Experimental-Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Vbox Configuration 
    # virtualisation.virtualbox.host.enable = true;
    # users.extraGroups.vboxusers.members = [ "lxudrr" ]; # user with access to virtualbox
    # virtualisation.virtualbox.host.enableExtensionPack = true;
    # virtualisation.virtualbox.guest.enable = true;
    # virtualisation.virtualbox.guest.x11 = true;

  # UnFree and UnSecure Software
  nixpkgs.config.allowUnfree = true;
      
  # NoNeedPassword
  security.sudo.wheelNeedsPassword = false;
   
  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lxudrr = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  users.users.enzo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    zsh    
    btop
    inetutils
    waybar
    dunst
    libnotify
    rofi-wayland
    hackgen-nf-font
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # allow Docker
  virtualisation.docker = {
  	enable = true;
  	rootless = {	
    	enable = true;
    	setSocketVariable = true;
  	};
  };
  
  
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?  
}






