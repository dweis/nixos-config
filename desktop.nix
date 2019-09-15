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
      #enableAdobeFlash = true;
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty
    google-chrome
    compton
    deadbeef
    firefoxWrapper
    glxinfo
    gnome3.dconf
    gnome3.dconf-editor
    i3blocks-gaps
    networkmanagerapplet
    numix-icon-theme
    numix-icon-theme-square
    numix-cursor-theme
    numix-gtk-theme
    paprefs
    pavucontrol
    rofi
    scrot
    spotify
    stack
    vlc
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
      lightdm = {
        enable = true;
        background = wallpaper;
      };
    };
    windowManager = {
      i3.package = pkgs.i3-gaps;
      i3.enable = true;
      default = "i3";
    };
  };

  services.upower.enable = true;
  systemd.services.upower.enable = true;

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
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
