# Módulo principal que llama al módulo de Kubernetes
provider "local" {}

# Llamamos al módulo de Kubernetes para instalarlo
module "kubernetes" {
  source = "./modules/kubernetes"
}


