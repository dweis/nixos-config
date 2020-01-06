{ pkgs, ... }:

let
  wallpaper = pkgs.copyPathToStore ./wallpaper.jpg;
in
{
  sound.enable = true;
  sound.mediaKeys.enable = true;
  hardware.pulseaudio.enable = true;   

  environment.systemPackages = with pkgs; [
    alacritty
    google-chrome
    glxinfo
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
    vscode
    xbindkeys
    xorg.xmodmap
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:super";
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      lightdm = {
        enable = true;
        background = wallpaper;
      };
      defaultSession = "none+i3";
    };
    windowManager = {
      i3.package = pkgs.i3-gaps;
      i3.enable = true;
    };
  };

  services.upower.enable = true;
  systemd.services.upower.enable = true;

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      ubuntu_font_family
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
