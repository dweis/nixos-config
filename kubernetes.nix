{ pkgs, ... }: 

{
  # Enable virtualbox.
  virtualisation.virtualbox.host.enable = true;

  # Enable docker.
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    # ---- Kubernetes / Docker
    docker
    docker-machine
    jsonnet
    minikube
    kubectl
    kubernetes-helm
  ];


}
