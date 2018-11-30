{ pkgs, ... }:

{
  # Enable sound.
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = true;   

  environment.systemPackages = with pkgs; [
    # ---- X
    compton
    feh
    glxinfo
    hyper
    networkmanagerapplet
    rofi
    scrot
    stack
    termite
    xbindkeys
    xorg.xmodmap
    xscreensaver
    hicolor-icon-theme
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:super";
    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
    displayManager = {
      slim = {
	enable = true;
	defaultUser = "derrick";
      };
      sessionCommands = with pkgs; lib.mkAfter
        ''
        xmodmap /path/to/.Xmodmap
        '';
    };
    windowManager = {
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
	  haskellPackages.taffybar
        ];
      };
      default = "xmonad";
    };
  };

  services.upower.enable = true;
  systemd.services.upower.enable = true;

  # Enable redshift
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
