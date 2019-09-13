# Depends on nixos hardware channel:
# $ sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
# $ sudo nix-channel --update nixos-hardware

{ pkgs, lib, ... }:

{
  networking.hostName = "monoid";

  # Network Manager.
  networking.networkmanager.enable = true;

  imports =
    [ 
      <nixos-hardware/lenovo/thinkpad/x1/6th-gen>
      ./hardware-configuration.nix
      ./base.nix
      ./audio.nix
      ./desktop.nix
      ./kubernetes.nix
      ./yubikey.nix
      #./steam.nix
    ];

  # Fix font sizes in X
  services.xserver.dpi = 144;
  fonts.fontconfig.dpi = 144;

  # Fix sizes of GTK/GNOME ui elements
  environment.variables = {
    #GDK_SCALE = lib.mkDefault "2";
    #GDK_DPI_SCALE = lib.mkDefault "0.5";
    WINIT_HIDPI_FACTOR = "2.0";
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth.enable = true;

  i18n.consoleFont = "ter-i32b";
  i18n.consolePackages = with pkgs; [ terminus_font ];

  boot.earlyVconsoleSetup = true;

  #services.colord.enable = true;
  environment.systemPackages = with pkgs; [
    argyllcms
    blueman
  ];

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.bluetooth.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
