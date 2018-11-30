# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  nixpkgs.config = {
    # Allow non-free
    allowUnfree = true;

    firefox = {
      enableGoogleTalkPlugin = true;
      # enableAdobeFlash = true;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # ---- General
    imagemagick7
    tmux
    # ---- Editors
    vim
    emacs
    nodePackages.tern        # spacemacs/js
    nodePackages.js-beautify # spacemacs/js
    nodePackages.eslint      # spacemacs/js
    ispell                   # spacemacs
    # ---- Internet
    firefox
    slack
    # ---- Kubernetes / Docker
    docker
    docker-machine
    minikube
    kubectl
    kubernetes-helm
    # ---- Network
    curl
    wget
    # ---- Programming
    awscli
    aws-sam-cli
    elixir
    erlang
    git
    nodejs-8_x
    python3
    python3Packages.pip
    python3Packages.setuptools
    python3Packages.virtualenv
    sbt
    scala
    zulu
    # ---- Printing / Scanning
    cups-filters
    # ---- System
    hyper
    pciutils
  ];

  programs = {
    zsh.enable = true;
    ssh.startAgent = true;
    light.enable = true; # Needed for the /run/wrappers/bin/light SUID wrapper.
  };

  # List services that you want to enable:
  
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  #networking.firewall.enable = false;
  
  # Allow 8612 for Sane to detect scanner
  networking.firewall.allowedUDPPorts  = [ 8612 ];
  
  # Only allow new users to be created via this file
  #users.mutableUsers = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.browsedConf = ''
    CreateIPPPrinterQueues No
  '';
  services.printing.drivers = [ pkgs.canon-cups-ufr2 pkgs.cups-filters ]; # pkgs.gutenprintBin pkgs.canon-cups-ufr2 ];

  # Enable AVAHI for printer discovery.
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  hardware.sane.enable = true;

  # Enable virtualbox
  virtualisation.virtualbox.host.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.derrick = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
    shell = "/run/current-system/sw/bin/zsh";
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      vistafonts
      inconsolata
      terminus_font
      proggyfonts
      dejavu_fonts
      font-awesome-ttf
      ubuntu_font_family
      powerline-fonts
      source-code-pro
      source-sans-pro
source-serif-pro
    ];
  };

  # Enable auto upgrades
  system.autoUpgrade.enable = true;
}
