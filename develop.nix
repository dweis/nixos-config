{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    awscli
    elixir
    erlang
    jsonnet
    nodejs-10_x
    python3
    python3Packages.pip
    python3Packages.setuptools
    python3Packages.virtualenv
    sbt
    scala
  ];

  programs.java = with pkgs; {
    enable = true;
    package = zulu;
  };
}
