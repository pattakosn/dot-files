# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # kernel options 
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jimpad15"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  # Generate these locales for multilingual support
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "fr_FR.UTF-8/UTF-8"
    "el_GR.UTF-8/UTF-8"
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # amd gpu
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  # Set default keyboard layout (can switch in GNOME UI)
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "grp:alt_shift_toggle"; # Allows switching layouts with Alt+Shift
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  #users.defaultUserShell = pkgs.zsh;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pattakosn = {
    isNormalUser = true;
    description = "Nikolas Pattakos";
    extraGroups = [ "input" "qemu-libvirtd" "libvirtd" "wheel" "video" "audio" "disk" "networkmanager" "docker" "vboxusers" ];
    #packages = with pkgs; [
    #];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # gnome/language
    gnome-initial-setup
    gnome-control-center
    gnome-tweaks
    flameshot
    hunspell
    hunspellDicts.en_US
    hunspellDicts.fr-moderne
    hunspellDicts.el_GR
    gnome-extensions-cli

    # utilities
    iotop
    htop
    btop
    btop-rocm
    nvtopPackages.amd
    hw-probe
    kdiskmark
    tldr
    bottom
    syncthing
    powertop
    lm_sensors
    hardinfo2
    fwupd
    
    # chat/video apps
    viber
    whatsapp-for-linux
    signal-cli
    signal-desktop
    telegram-desktop
    discord
    
    # browsers 
    google-chrome
    
    # notes
    joplin
    joplin-desktop
    nb
    obsidian
    
    # media
    stremio
    vlc
    mpv
    plexamp
    plex-desktop
    fragments
    transmission-remote-gtk
    spotify
    blueman

    # cli tools
    stow
    ranger
    yazi
    minikube
    kind
    arkade
    yq
    jq
    k9s
    lazydocker
    lazygit
    zoxide
    ookla-speedtest
    github-markdown-toc-go
    
 
    # gh relates packages/addons
    git-extras
    gh-dash
    git-lfs
    git
    gh
    delta
    keychain
    diff-so-fancy
    
    # office
    libreoffice-fresh
    
    # remote desktop 
    #rustdesk
    anydesk
    #teamviewer
    
    # terminal apps
    ghostty
    kitty
    
    # code
    vscode
    jetbrains.goland
    cmakeWithGui
    git
    gdb
    gdbgui
    ddd
    vscode
    python3
    uv
    gcc
    clang
    adaptivecppWithRocm
    sycl-info
    
    # make tools 
    gnumake
    rake
    go-task
    mage
    xc
    
    # secrets 
    keepassxc
    git-crypt

    # cli tools 
    wget
    curl
    vim-full
    bc
    rsync
    ipmitool

    # vm/container related
    docker
    qemu
    
    # network tools
    nmap
    iputils
    whois
    #undollar
    #rustscan
    #masscan
    #amass
    #netcat
    #naabu
    #nikto
    #sipvicious
    
    # vpn/mesh related
    tailscale
    
    # shell related 
    bash
    zsh
    tmux
  ];

  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true; 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
  #   enableSSHSupport = true;
  };
  # using OpenSSH's ssh-agent instead.
  #programs.gnupg.agent.enableSSHSupport = false;  # (this is the default)
  programs.ssh.startAgent = true;
  # New versions of OpenSSH seem to default to disallowing all `ssh-add -s`
  # calls when no whitelist is provided, so this becomes necessary.
  programs.ssh.agentPKCS11Whitelist = "${pkgs.opensc}/lib/opensc-pkcs11.so";

  # List services that you want to enable:
  # tailscale
  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "client";
  services.tailscale.extraSetFlags = [
  	#"--advertise-exit-node"
	#"--accept-routes"
	# "--accept-dns=true"
	#"--ssh"
  ];

  services.fwupd.enable = true;

  ## thinkpad fan control
  #services.thinkfan.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  ## exp features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## optimise the store and garbage collect
  nix.settings.auto-optimise-store = true;
}
