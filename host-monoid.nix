# Depends on nixos hardware channel:
# $ sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
# $ sudo nix-channel --update nixos-hardware

{ pkgs, ... }:

{
  networking.hostName = "monoid";

  # Network Manager.
  networking.networkmanager.enable = true;

  imports =
    [ 
      <lenovo/thinkpad/x1/6th-gen>
      ./hardware-configuration.nix
      ./base.nix
      ./desktop.nix
      ./kubernetes.nix
      ./steam.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.plymouth.enable = true;

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  programs = {
    light.enable = true; # Needed for the /run/wrappers/bin/light SUID wrapper.
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
