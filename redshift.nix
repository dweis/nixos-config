{ pkgs, ... }:

{
  services.redshift = {
    enable = true;
    latitude = "44.39";
    longitude = "-79.69";
    temperature = {
      day = 6500;
      night = 5000;
    };
    brightness = {
      day = "1.0";
      night = "0.7";
    };
  };
}
