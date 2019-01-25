{ config, pkgs, ... }:

{
  imports =
    [
      ./develop.nix
      ./ledger-nano-s.nix
      ./users.nix
      ./printscan.nix
      ./firewall.nix
    ];

  nixpkgs.config = {
    # Allow non-free
    allowUnfree = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "America/Toronto";

  environment.systemPackages = with pkgs; [
    imagemagick7
    stow # dotfile management
    vim
    emacs
    file
    killall
    nodePackages.tern        # spacemacs/js
    nodePackages.js-beautify # spacemacs/js
    nodePackages.eslint      # spacemacs/js
    ispell                   # spacemacs
    slack
    curl
    wget
    git
    pciutils
    tmux
    unzip
    usbutils
    zip
  ];

  programs = {
    zsh.enable = true;
    ssh.startAgent = true;
  };

  services.openssh.enable = true;

  hardware.ledger-nano-s.enable = true;

  system.autoUpgrade.enable = true;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";
}
