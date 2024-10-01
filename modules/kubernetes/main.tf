# Definimos el proveedor "local" para ejecutar comandos en la máquina local
provider "local" {}
# Recurso para la instalación de Docker y Kubernetes en un sistema Debian
resource "null_resource" "install_kubernetes" {
  # Usamos un provisioner "local-exec" para ejecutar comandos en la máquina
  provisioner "local-exec" {
    # Comando que se ejecutará para instalar Docker, kubeadm, kubelet y kubectl
    command = <<-EOT
      # Actualizamos los repositorios y el sistema
      sudo apt update

      # Instalamos Docker, necesario para los contenedores de Kubernetes
      sudo apt install -y docker.io

      # Habilitamos e iniciamos Docker para que esté siempre disponible
      sudo systemctl enable docker
      sudo systemctl start docker

      # Instalamos los paquetes de transporte necesarios para obtener los binarios de Kubernetes
      sudo apt install -y apt-transport-https curl

      # Creamos el directorio para almacenar las claves de Kubernetes si no existe
      sudo mkdir -p /etc/apt/keyrings

      # Descargamos la clave pública del repositorio de Kubernetes
      curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

      # Añadimos el repositorio de Kubernetes
      echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

      # Actualizamos los repositorios nuevamente para obtener los paquetes de Kubernetes
      sudo apt update

      # Instalamos kubelet, kubeadm y kubectl
      sudo apt install -y kubelet kubeadm kubectl

      # Deshabilitamos el swap en el sistema, requerido por Kubernetes
      sudo swapoff -a

      # Inicializamos el clúster de Kubernetes
      #sudo kubeadm init --pod-network-cidr=192.168.2.0/16
       sudo kubeadm init --pod-network-cidr=${var.pod_network_cidr}
       
      # Creamos el directorio para almacenar la configuración de kubectl
      mkdir -p $HOME/.kube

      # Copiamos el archivo de configuración del clúster para poder usar kubectl
      sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

      # Cambiamos el propietario del archivo para el usuario actual
      sudo chown $(id -u):$(id -g) $HOME/.kube/config

      # Instalamos Flannel como la red de pods (CNI)
      kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    EOT
  }
}

# Output para devolver la ruta del archivo de configuración de Kubernetes
output "kube_config_path" {
  description = "Ruta al archivo de configuración de Kubernetes (kubectl)."
  value       = "$HOME/.kube/config"
}
