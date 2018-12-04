{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    awscli
    aws-sam-cli
    elixir
    erlang
    nodejs-8_x
    python3
    python3Packages.pip
    python3Packages.setuptools
    python3Packages.virtualenv
    sbt
    scala
    zulu
  ];
}