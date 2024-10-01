# Definimos un recurso de tipo null_resource llamado install_kubernetes
# Este recurso se usa para ejecutar comandos de instalación en la máquina local.
resource "null_resource" "install_kubernetes" {

  # El provisioner "local-exec" ejecuta comandos en la máquina local donde se está aplicando Terraform.
  provisioner "local-exec" {
    
    # Aquí se definen los comandos necesarios para instalar Kubernetes.
    # 1. Actualiza los índices de los paquetes del sistema.
    # 2. Instala dependencias necesarias: apt-transport-https, ca-certificates, curl, y gnupg.
    # 3. Descarga la clave pública del repositorio de Kubernetes.
    # 4. Añade el repositorio de Kubernetes.
    # 5. Actualiza el índice de paquetes con el nuevo repositorio.
    # 6. Instala kubelet, kubeadm y kubectl.
    command = <<EOT
      # Actualizamos el índice de los paquetes apt en el sistema
      sudo apt-get update
      
      # Instalamos las dependencias necesarias: apt-transport-https, ca-certificates, curl y gnupg
      sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
      
      # Descargamos la clave pública del repositorio de Kubernetes y la guardamos
      curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo tee /etc/apt/trusted.gpg.d/kubernetes.asc
      
      # Añadimos el repositorio de Kubernetes al archivo de fuentes
      echo 'deb https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
      
      # Actualizamos de nuevo el índice de paquetes con el nuevo repositorio
      sudo apt-get update
      
      # Instalamos kubelet, kubeadm y kubectl
      sudo apt-get install -y kubelet kubeadm kubectl
    EOT
  }
  
  # Lifecycle: Se especifica que este recurso no puede ser destruido directamente
  # Esto evita que Terraform lo borre accidentalmente.
  lifecycle {
    prevent_destroy = true
  }
}
