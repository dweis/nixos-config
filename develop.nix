{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    awscli
    elixir
    erlang
    google-cloud-sdk
    jsonnet
    nodejs-10_x
    python3
    python3Packages.pip
    python3Packages.setuptools
    python3Packages.virtualenv
    sbt
    scala
    zulu
  ];
}
