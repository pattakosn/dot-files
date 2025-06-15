# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #boot.initrd.luks.devices."cryptroot".allowDiscards = true;

  networking.hostName = "jimpad"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };
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
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "grp:alt_shift_toggle"; # Allows switching layouts with Alt+Shift
  };
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };
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
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pattakosn = {
    isNormalUser = true;
    description = "Nikolas Pattakos";
    extraGroups = [ "input" "qemu-libvirtd" "libvirtd" "wheel" "video" "audio" "disk" "networkmanager" "docker" "vboxusers" "dialout"];
  };

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
    smartmontools
    hardinfo2
    gkrellm
    mission-center
    resources
    monitorets
    glances
    conky
    hddtemp
    fwupd
    clinfo
    pigz
    czkawka
    
    # chat/video apps
    viber
    whatsapp-for-linux
    signal-cli
    signal-desktop
    telegram-desktop
    discord
    
    # browsers 
    google-chrome
    tor-browser-bundle-bin
    
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
    #vscode
    #(
    #  (vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: {
    #    src = fetchTarball {
    #      url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
    #      sha256 = "03xpfjr1m8jrbwig0ybrf9646v275hdzvd3yzzrdc7834fvqx7my";#lib.fakeSha256;
    #    };
    #    version = "latest";
    #    buildInputs = oldAttrs.buildInputs ++ [ krb5 ];
    #  })
    #)
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        ms-vscode.cpptools
        ms-vscode.cpptools-extension-pack
        
        ms-vscode.cmake-tools

        fortran-lang.linter-gfortran
        formulahendry.code-runner

        eamodio.gitlens
        mhutchie.git-graph
        donjayamanne.githistory
        waderyan.gitblame

        github.copilot
        github.copilot-chat

        ms-vscode-remote.remote-containers
        ms-azuretools.vscode-docker
      ];
    })
    fortls
    jetbrains.goland
    jetbrains.clion
    arduino-ide
    platformio-core
    cmakeWithGui
    git
    gdb
    gdbgui
    ddd
    python3
    uv
    gcc
    gfortran
    clang
    clang-tools
    valgrind
    go
    rustup
    adaptivecppWithRocm
    rocmPackages.rocminfo
    sycl-info
    nodejs
    qt6.full
    qtcreator
    eigen
    vulkan-tools
    vulkan-loader
    vulkan-headers
    vulkan-caps-viewer
    vulkan-tools-lunarg
    vulkan-extension-layer
    vulkan-memory-allocator
    vulkan-validation-layers
    vulkan-utility-libraries
    vk-bootstrap
    vkmark
    furmark
    amdvlk
    memtest_vulkan
    renderdoc
    gpu-viewer
    pkg-config
    mesa
    sdl3
    xorg.libX11
    xorg.libXrandr
    xorg.libXi
    xorg.libXcursor
    xorg.libXinerama
    
    # make tools 
    gnumake
    rake
    go-task
    mage
    xc
    
    # secrets 
    keepassxc
    git-crypt
    backintime-qt

    # cli tools 
    wget
    curl
    bc
    rsync
    ipmitool
    hugo

    ((vim_configurable.override {  }).customize{
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace vim-polyglot coc-nvim nerdtree auto-pairs vim-airline vim-airline-themes vim-cmake dracula-vim taglist cscope];
        opt = [];
      };
      vimrcConfig.customRC = ''
        " your custom vimrc
        set nocompatible
        set backspace=indent,eol,start
        " Turn on syntax highlighting by default
        syntax on
        filetype plugin indent on

        set tabstop=8
        set expandtab
        set softtabstop=8
        set shiftwidth=8
        set autoindent
        set smartindent

        " relative line numbers 
        set rnu

        " use tab to trigger completion and navigate to next complete item
        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1] =~ '\s'
        endfunction
        inoremap <silent><expr> <Tab>
              \ pumvisible() ? "\<C-n>" :
              \ <SID>check_back_space() ? "\<Tab>" :
              \ coc#refresh()
        
        set termguicolors
        colo dracula
        let g:airline_theme='dracula'
        
        nnoremap <leader>n :NERDTreeFocus<CR>
        nnoremap <C-n> :NERDTreeToggle<CR>
        " Start NERDTree and put the cursor back in the other window.
        autocmd VimEnter * NERDTree
        autocmd VimEnter * wincmd p
        " Exit Vim if NERDTree is the only window remaining in the only tab.
        autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
        " Close the tab if NERDTree is the only window remaining in it.
        autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
        
        " !!!! INSTALL ccls vim with coc !!!
        " Use F8 to open tagbar display
        nmap <F8> :TagbarToggle<CR>
        
        " Use F7 to open tagbar display
        nmap <F7> :Tlist<CR>
        "Show Taglist window on the right side
        let Tlist_Use_Right_Window = 1
        "Close folds for inactive files
        let Tlist_File_Fold_Auto_Close=1
        " point taglist to ctags
        "let Tlist_Ctags_Cmd='/usr/bin/ctags'
        
        " Use F9 to set build dir to ../build
        nmap <F9> :set makeprg=make\ -C\ ../build<CR>
        
        if has('cscope')
          set cscopetag cscopeverbose
        
          if has('quickfix')
            set cscopequickfix=s-,c-,d-,i-,t-,e-
          endif
        
        "  cnoreabbrev csa cs add
        "  cnoreabbrev csf cs find
        "  cnoreabbrev csk cs kill
        "  cnoreabbrev csr cs reset
        "  cnoreabbrev css cs show
        "  cnoreabbrev csh cs help
          cnoreabbrev <expr> csa  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs add'  : 'csa')
          cnoreabbrev <expr> csf  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs find' : 'csf')
          cnoreabbrev <expr> csk  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs kill' : 'csk')
          cnoreabbrev <expr> csr  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs reset' : 'csr')
          cnoreabbrev <expr> css  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs show' : 'css')
          cnoreabbrev <expr> csh  ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs help' : 'csh')
        
          command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
        endif
        
        "Remove all trailing whitespace by pressing F5
        nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
      '';
      }
    )
    ctags

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
  virtualisation.docker.storageDriver = "btrfs";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
  #  enableSSHSupport = true;
  };

  # List services that you want to enable:
  programs.ssh.startAgent = true;
  programs.seahorse.enable = true;
  services.gnome.gnome-keyring.enable = true;
  
  # New versions of OpenSSH seem to default to disallowing all `ssh-add -s`
  # calls when no whitelist is provided, so this becomes necessary.
  programs.ssh.agentPKCS11Whitelist = "${pkgs.opensc}/lib/opensc-pkcs11.so";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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

  ## exp features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## optimise the store and garbage collect
  nix.settings.auto-optimise-store = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

