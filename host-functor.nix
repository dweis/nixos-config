{ pkgs, ... }:

{
  networking.hostName = "functor";

  imports =
    [
      ./hardware-configuration.nix
      ./base.nix
      ./desktop.nix
      ./kubernetes.nix
      ./steam.nix
      ./yubikey.nix
      ./minecraft.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network Manager.
  networking.networkmanager.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.driSupport32Bit = true;
  services.xserver.xrandrHeads = [ "DP-4" "DP-2" ];

  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    support32Bit = true;

    daemon.config = {
      flat-volumes = "no";
      default-sample-format = "s24le";
      default-sample-rate = "192000";
      resample-method = "speex-float-10";
      avoid-resampling = "true";
    };

    package = pkgs.pulseaudioFull;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
