# Recurso para ejecutar comandos de instalación de Kubernetes en la máquina
resource "null_resource" "install_kubernetes" {

  # Usamos el provisioner local-exec para ejecutar comandos en la máquina local
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

      # Actualizamos nuevamente el índice de paquetes para incluir el nuevo repositorio.
      sudo apt-get update

      # Instalamos los componentes principales de Kubernetes: kubelet, kubeadm y kubectl.
      sudo apt-get install -y kubelet kubeadm kubectl
    EOT
  }
}
