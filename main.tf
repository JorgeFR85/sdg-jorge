# Definimos un recurso "null_resource" para ejecutar comandos locales para la instalación de Kubernetes.
resource "null_resource" "install_kubernetes" {

  # Utilizamos un provisionador "local-exec" que ejecuta los comandos locales en la máquina.
  provisioner "local-exec" {
    # Los comandos que se ejecutarán en la máquina para instalar Kubernetes.
    command = <<EOT
      # Actualizamos el índice de los paquetes apt en el sistema.
      # sudo apt-get update

      # Instalamos las dependencias necesarias: apt-transport-https, ca-certificates, curl, y gnupg.
        sudo apt-get install -y apt-transport-https ca-certificates curl gnupg

      # Creamos el directorio /etc/apt/keyrings si no existe.
      # sudo mkdir -p /etc/apt/keyrings

      # Descargamos la clave pública del repositorio de Kubernetes y la guardamos en /etc/apt/keyrings.
      # curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

      # Añadimos el repositorio de Kubernetes al archivo /etc/apt/sources.list.d/kubernetes.list.
      # echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

      # Actualizamos de nuevo el índice de paquetes con el nuevo repositorio.
      # sudo apt-get update

      # Instalamos los paquetes kubelet, kubeadm y kubectl.
      sudo apt-get install -y kubelet kubeadm kubectl
    EOT
  }

  # El ciclo de vida del recurso está configurado para evitar su destrucción.
  lifecycle {
    prevent_destroy = true
  }
}

# Añadimos salidas para obtener información útil como la IP del master y el kubeconfig.
output "master_ip" {
  value = "192.168.2.26" # Cambia a la IP del nodo master si es necesario.
}

output "kubeconfig" {
  value = "/etc/kubernetes/admin.conf" # Ruta del kubeconfig, si es necesario.
}
