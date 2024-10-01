# Este recurso `null_resource` ejecutará comandos para instalar Kubernetes en una máquina Debian
resource "null_resource" "install_kubernetes" {
  
  # Utilizamos el provisioner `local-exec` para ejecutar comandos en la máquina local
  provisioner "local-exec" {

    # El bloque de comandos que ejecutaremos:
    command = <<-EOT
      # Actualizar los índices de los paquetes del sistema
      sudo apt-get update &&
      
      # Instalar dependencias necesarias para Kubernetes
      sudo apt-get install -y apt-transport-https ca-certificates curl gnupg &&
      
      # Crear el directorio de keyrings si no existe
      sudo mkdir -p /etc/apt/keyrings &&
      
      # Descargar la llave pública firmada del repositorio de Kubernetes
      curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg &&
      
      # Agregar el repositorio de Kubernetes a la lista de fuentes
      echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list &&
      
      # Volver a actualizar los índices de los paquetes tras añadir el repositorio
      sudo apt-get update
    EOT
  }
}
