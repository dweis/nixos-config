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
  };

  environment.systemPackages = with pkgs; [
    alacritty
    google-chrome
    firefoxWrapper
    glxinfo
    scrot
    spotify
    stack
    vlc
    vscode
    xbindkeys
    xorg.xmodmap
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "caps:super";
    desktopManager = {
      plasma5.enable = true;
    };
    displayManager = {
      sddm.enable = true;
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
}
