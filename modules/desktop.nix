{ pkgs, ... }:

{
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = true;   

  nixpkgs.config = {
    firefox = {
      enableGoogleTalkPlugin = true;
      enableAdobeFlash = true;
    };

    chromium = {
      enablePepperFlash = true; # Chromium removed support for Mozilla (NPAPI) plugins so Adobe Flash no longer works 
      enablePepperPDF = true;
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty
    chromium
    compton
    feh
    firefoxWrapper
    glxinfo
    hicolor-icon-theme # for taffybar battery icon
    gnome3.adwaita-icon-theme # for taffybar battery icon
    hyper
    networkmanagerapplet
    rofi
    scrot
    stack
    termite
    volumeicon
    vscode
    xbindkeys
    xorg.xmodmap
    xscreensaver
  ];

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
      i3.package = pkgs.i3-gaps;
      i3.enable = true;
      default = "i3";
    };
  };

  services.upower.enable = true;
  systemd.services.upower.enable = true;

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

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      vistafonts
      inconsolata
      terminus_font
      proggyfonts
      dejavu_fonts
      font-awesome-ttf
      ubuntu_font_family
      powerline-fonts
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
  };
}
