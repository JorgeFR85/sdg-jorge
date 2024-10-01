# Proveedor de Terraform para ejecutar comandos locales
provider "null" {}

# Recurso para instalar Kubernetes en la máquina usando el provisioner local-exec
resource "null_resource" "install_kubernetes" {
  provisioner "local-exec" {
    command = <<EOT
      # Actualizamos el índice de paquetes apt en el sistema
      sudo apt-get update

      # Instalamos las dependencias necesarias para Kubernetes
      sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

      # Creamos el directorio para almacenar las claves de Kubernetes si no existe
      sudo mkdir -p /etc/apt/keyrings

      # Descargamos la clave pública del repositorio de Kubernetes
      curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

      # Añadimos el repositorio de Kubernetes
      echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

      # Actualizamos el índice de paquetes nuevamente
      sudo apt-get update

      # Instalamos kubelet, kubeadm y kubectl
      sudo apt-get install -y kubelet kubeadm kubectl

      # Inicializamos el clúster de Kubernetes
      sudo kubeadm init --pod-network-cidr=192.168.0.0/16

      # Configuramos kubectl para el usuario root
      mkdir -p $HOME/.kube
      sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
      sudo chown $(id -u):$(id -g) $HOME/.kube/config

      # Desplegamos el plugin de red Calico
      kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
    EOT
  }
}

# Salida que muestra la IP del nodo maestro de Kubernetes
output "master_ip" {
  description = "La IP del nodo maestro del clúster"
  value       = "192.168.2.25"
}

# Salida que muestra el archivo de configuración de kubeconfig
output "kubeconfig" {
  description = "Archivo de configuración para conectar a Kubernetes"
  value       = "/etc/kubernetes/admin.conf"
  sensitive   = true
}
