resource "null_resource" "install_kubernetes" {
  provisioner "local-exec" {
    command = <<EOT
      # Actualizar los repositorios e instalar dependencias
      sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl

      # Descargar la clave GPG y agregar el repositorio correcto para Debian bullseye
      sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
      echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-buster main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

      # Actualizar los repositorios e instalar kubeadm, kubelet y kubectl
      sudo apt-get update && sudo apt-get install -y kubelet kubeadm kubectl

      # Marcar kubeadm, kubelet y kubectl para que no se actualicen automáticamente
      sudo apt-mark hold kubelet kubeadm kubectl

      # Inicializar el clúster de Kubernetes con kubeadm
      sudo kubeadm init --apiserver-advertise-address=192.168.2.26 --pod-network-cidr=192.168.0.0/16

      # Configurar kubectl para el usuario actual
      mkdir -p $HOME/.kube
      sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
      sudo chown $(id -u):$(id -g) $HOME/.kube/config

      # Instalar la red de Calico para el clúster de Kubernetes
      kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
    EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
