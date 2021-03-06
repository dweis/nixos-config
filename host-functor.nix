{ pkgs, ... }:

{
  networking.hostName = "functor";

  imports =
    [
      ./hardware-configuration.nix
      ./base.nix
      ./audio.nix
      ./desktop.nix
      ./kubernetes.nix
      ./steam.nix
      ./yubikey.nix
      ./minecraft.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  i18n.consoleFont = "Lat2-Terminus16";

  # Network Manager.
  networking.networkmanager.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.driSupport32Bit = true;
  services.xserver.xrandrHeads = [ "DP-0" "DP-2" ];

  services.xserver.displayManager.gdm.wayland = false;
  programs.sway.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
