# Output para mostrar la IP del nodo master de Kubernetes
output "kubernetes_config" {
  description = "Ruta al archivo de configuración de Kubernetes"
  value       = module.kubernetes.kube_config_path
}
