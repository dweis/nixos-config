{ pkgs, ... }: 

{
  # Enable virtualbox.
  #virtualisation.virtualbox.host.enable = true;

  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  virtualisation.libvirtd.enable = true;

  # Enable docker.
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    # ---- Kubernetes / Docker
    docker
    docker-machine
    minikube
    kubectl
    kubernetes-helm
  ];


}
