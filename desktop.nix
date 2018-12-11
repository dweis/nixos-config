{ pkgs, ... }:

let 
  wallpaper = pkgs.copyPathToStore ./wallpaper.jpg;
in
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
    calibre
    chromium
    compton
    firefoxWrapper
    glxinfo
    gnome3.dconf
    gnome3.dconf-editor
    hyper
    i3blocks-gaps
    lightlocker
    networkmanagerapplet
    numix-icon-theme
    numix-icon-theme-square
    numix-cursor-theme
    numix-gtk-theme
    rofi
    scrot
    spotify
    stack
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
      default = "mate";
      xterm.enable = false;
      mate.enable = true;
    };
    displayManager = {
      lightdm = {
        enable = true;
        background = wallpaper;
      };
      sessionCommands = with pkgs; lib.mkAfter
        ''
        xmodmap /path/to/.Xmodmap
        '';
    };
    windowManager = {
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
      emojione
    ];
  };

  environment.extraInit = ''
      # GTK3 theme
      export GTK_THEME="Numix"
    '';

  environment.etc."xdg/gtk-3.0/settings.ini" = {
      text = ''
        [Settings]
        gtk-icon-theme-name=Numix Square
        gtk-theme-name=Numix
        gtk-application-prefer-dark-theme = false
      '';
      mode = "444";
    };

    environment.etc."gtk-2.0/gtkrc" = {
      text = ''
        gtk-icon-theme-name=Numix Square
      '';
      mode = "444";
  };
}
