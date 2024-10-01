# Definimos el recurso principal de instalación de Kubernetes
resource "null_resource" "install_kubernetes" {

  # Provisioner para ejecutar comandos locales en el servidor para instalar Kubernetes
  provisioner "local-exec" {
    command = <<EOT
      # Actualizamos el índice de los paquetes apt en el sistema.
      sudo apt-get update

      # Instalamos las dependencias necesarias para Kubernetes.
      sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

      # Creamos el directorio /etc/apt/keyrings si no existe.
      sudo mkdir -p /etc/apt/keyrings

      # Descargamos la clave pública del repositorio de Kubernetes.
      curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

      # Añadimos el repositorio de Kubernetes a /etc/apt/sources.list.d/kubernetes.list.
      echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

      # Actualizamos nuevamente el índice de paquetes.
      sudo apt-get update

      # Instalamos kubeadm, kubelet y kubectl.
      sudo apt-get install -y kubelet kubeadm kubectl

      # Evitamos que se actualicen automáticamente.
      sudo apt-mark hold kubelet kubeadm kubectl
    EOT
  }
}

