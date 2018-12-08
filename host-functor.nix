{ pkgs, ... }:

{
  networking.hostName = "functor";

  imports =
    [
      ./hardware-configuration.nix
      ./ledger-nano-s.nix
      ./base.nix
      ./desktop.nix
      ./kubernetes.nix
      ./steam.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network Manager.
  networking.networkmanager.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
  services.xserver.xrandrHeads = [ "DP-4" "DP-2" ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
