{ config, lib, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ./home/programs/stylix/default.nix
  ];
  
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
    kernelPackages = pkgs.linuxPackages_6_9; # Get latest linux kernel
  };

  networking.hostName = "nixos";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-k22n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
    # useXkbConfig = true; # use xkb.options in tty.
  };

  # Dark Theme
  environment.variables = {
    GTK_THEME = "Adwaita-dark";
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };
  services.gnome.gnome-keyring.enable = true; # necessary for Adwaita theme
	services.dbus.enable = true; # necessary for gtk apps
	qt.platformTheme = "qt5ct";


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
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  
  services.jenkins = {
    enable = true;
  };
  
  # Experimental-Features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # UnFree and UnSecure Software
  nixpkgs.config.allowUnfree = true;  
      
  # NoNeedPassword
  security.sudo.wheelNeedsPassword = false;
   
  # Enable sound.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.lxudrr = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "video" "wireshark" "libvirtd" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    zsh    
    btop
    inetutils
    waybar
    dunst
    libnotify
    wofi
    swww
    hackgen-nf-font
    jrnl
	# ciscoPacketTracer8
  ];


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

	virtualisation.libvirtd = {
		enable = true;
		qemu = {
			package = pkgs.qemu_kvm;
			runAsRoot = true;
			swtpm.enable = true;
			ovmf = {
				enable = true;
				packages = [(pkgs.OVMF.override {
					secureBoot = true;
					tpmSupport = true;
				}).fd];
			};
		};
	};  
  programs.virt-manager.enable = true; 

  
  # Allow dumcap (wireshark) to use interface 
  security.wrappers.dumpcap = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_raw+ep";
    source = "${pkgs.wireshark}/bin/dumpcap";
  };
  
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "mydatabase" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host  all       all     127.0.0.1/32    md5
    '';
  };
  
	#nixpkgs.overlays = [
    # cisco manual installation
	#(_: prev: {
	# ciscoPacketTracer8 = prev.ciscoPacketTracer8.overrideAttrs (_: {
	#   src = ./packet-tracer.deb;
	# });
	#})
	#];
    
  networking.firewall.enable = false;

  system.stateVersion = "23.11";
}

