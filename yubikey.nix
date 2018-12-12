{ pkgs, ... }:

{
  services.pcscd.enable = true;

  environment.systemPackages = with pkgs; [
    yubioath-desktop
    yubikey-personalization
    yubikey-personalization-gui
  ];

  services.udev.packages = with pkgs; [
    yubikey-personalization
  ];
}
