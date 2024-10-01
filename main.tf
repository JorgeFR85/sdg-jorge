# Módulo principal que llama al módulo de Kubernetes
module "kubernetes" {
  source = "./modules/kubernetes"  # Ruta hacia el módulo de Kubernetes

  # Pasamos la variable master_ip al módulo
  master_ip = var.master_ip
}
