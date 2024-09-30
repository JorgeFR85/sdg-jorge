resource "null_resource" "install_kubernetes" {
  # Instalacion nodo maestro
  provisioner "local-exec" {
    command = <<EOT
      # Dependencias
      sudo apt-get update && sudo apt-get install -y apt-transport-https curl

      # Agregar la clave GPG de Kubernetes
      curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

      # Repo de Kubernetes
      echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

      # Instalacion kubelet, kubectl y kubeadm
      sudo apt-get update && sudo apt-get install -y kubelet kubeadm kubectl

      # Se arranca el cluster
      sudo kubeadm init --apiserver-advertise-address=${var.master_ip} --pod-network-cidr=192.168.2.0/16

      # Configurar usuario no root
      mkdir -p $HOME/.kube
      sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
      sudo chown $(id -u):$(id -g) $HOME/.kube/config

      # Instalacion de calico
      kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
    EOT
  }

  # Retardo hasta que nodo master este listo
  provisioner "local-exec" {
    command = "sleep 60"
  }
}

# Desplegar nodos 
resource "null_resource" "install_workers" {
  count = length(var.worker_ips)

  provisioner "local-exec" {
    command = <<EOT
      # Ejecutar el comando para unirse al nodo maestro
      sudo kubeadm join ${var.master_ip}:6443 --token <token> --discovery-token-ca-cert-hash sha256:<hash>
    EOT
  }
}
