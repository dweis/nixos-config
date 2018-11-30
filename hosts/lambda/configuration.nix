# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  networking.hostName = "lambda";

  # Network Manager
  networking.networkmanager.enable = true;

  imports =
    [ 
      ./common.nix
      ./hardware-configuration.nix
      ./services/xserver.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable Bumblebee
  hardware.bumblebee.enable = true;
  hardware.bumblebee.connectDisplay = true;

  users.users.derrick.packages = [
    pkgs.steam
  ];

  services.xserver.videoDrivers = ["nvidia-beta" "intel"];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # install nvidia drivers in addition to intel one
  hardware.opengl.extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];

  # Support backlight buttons
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/wrappers/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/wrappers/bin/light -A 10"; }
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
