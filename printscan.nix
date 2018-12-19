{ pkgs, ... }:

{
  networking.firewall.allowedUDPPorts = [
    8612 # Allow 8612 for Sane to detect scanner
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.browsedConf = ''
    CreateIPPPrinterQueues No
  '';
  services.printing.drivers = [ pkgs.canon-cups-ufr2 pkgs.cups-filters ]; # pkgs.gutenprintBin pkgs.canon-cups-ufr2 ];

  # Enable AVAHI for printer discovery.
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # Enable scanning.
  hardware.sane.enable = true;

  environment.systemPackages = with pkgs; [
    cups-filters
  ];
}
