{ ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.derrick = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" ];
    shell = "/run/current-system/sw/bin/zsh";
  };
}