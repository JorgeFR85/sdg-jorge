# Módulo principal que llama al módulo de Kubernetes
provider "local" {}

# Llamamos al módulo de Kubernetes para instalarlo
module "kubernetes" {
  source = "/modules/kubernetes"
}

# Output para mostrar la configuración del clúster
output "kubernetes_config" {
  description = "Ruta al archivo de configuración del clúster de Kubernetes"
  value       = module.kubernetes.kube_config_path
}

