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
  
  zramSwap.enable = true;
  zramSwap.memoryPercent = 25;
  
  programs.light.enable = true;

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
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lxudrr = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "video" "wireshark" ];
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
    swww
    hackgen-nf-font
    jrnl
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
  
  # Register AppImage files as a binary type to binfmt_misc
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };


    services.nginx = {
    enable = true;
    virtualHosts = {
      "localhost" = {  
        root = "/var/www/homePage";
	listen = [
	 {
	   addr = "localhost";
	   port = 1234;	
	 }
	];
      };
      "192.168.0.148" = {  
        root = "/var/www/memnad_pwa";
	listen = [
	 {
	   addr = "192.168.0.148";
	   port = 1234;
	 }
	];
      };
    };
  };

  
  # Allow dumcap (wireshark) to use interface 
  security.wrappers.dumpcap = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_raw+ep";
    source = "${pkgs.wireshark}/bin/dumpcap";
  };

   
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  system.stateVersion = "23.11";
}






