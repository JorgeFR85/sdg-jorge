provider "local" {}

provider "null" {}

# Definir el módulo de Kubernetes
module "kubernetes" {
  source = "./modules/kubernetes"

  # Pasar variables necesarias al módulo
  master_ip = var.master_ip
  worker_ips = var.worker_ips
}

# (Opcional) Crear un namespace en Kubernetes después de la instalación
resource "kubernetes_namespace" "kubernetes-jorge" {
  metadata {
    name = "newyork"
  }
}
